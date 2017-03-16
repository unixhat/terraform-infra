resource "aws_key_pair" "mykey" {
  key_name = "mykey"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}

resource "aws_instance" "example" {
  ami = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.mykey.key_name}"
  subnet_id = "${aws_subnet.main-public-1.id}"
  vpc_security_group_ids = ["${aws_security_group.allow-ssh.id}"]
  user_data = "${data.template_cloudinit_config.cloudinit-example.rendered}"

  provisioner "file" {
    source = "script.sh"
    destination = "/tmp/script.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh"
    ]
  }
  connection {
    user = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
  }
}

resource "aws_ebs_volume" "ebs-volume-1" {
    availability_zone = "ap-southeast-1a"
    size = 20
    type = "gp2"
    tags {
        Name = "extra volume for data"
    }
}

resource "aws_volume_attachment" "ebs-volume-1-attachment" {
  device_name = "${var.INSTANCE_DEVICE_NAME}"
  volume_id = "${aws_ebs_volume.ebs-volume-1.id}"
  instance_id = "${aws_instance.example.id}"
}

output "ip" {
    value = "${aws_instance.example.public_ip}"
}

