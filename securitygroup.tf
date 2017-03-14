resource "aws_security_group" "allow-ssh" {
  vpc_id = "${aws_vpc.main.id}"
  name = "allow-ssh"
  description = "security group that allows ssh and all egress traffic"
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
tags {
    Name = "allow-ssh"
  }
}

data "aws_ip_ranges" "southeast_ec2" {
  regions = [ "ap-southeast-1", "ap-southeast-2" ]
  services = [ "ec2" ]
}

resource "aws_security_group" "from_southeast" {
 name = "from_southeast"

  ingress {
    from_port = "443"
    to_port = "443"
    protocol = "tcp"
    cidr_blocks = [ "${data.aws_ip_ranges.southeast_ec2.cidr_blocks}" ]
  }
  tags {
    CreateDate = "${data.aws_ip_ranges.southeast_ec2.create_date}"
    SyncToken = "${data.aws_ip_ranges.southeast_ec2.sync_token}"
  }

}
