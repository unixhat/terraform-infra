output "instance" {
  value = "${aws_instance.example.public_ip}"
}
output "rds" {
  value = "${aws_db_instance.mariadb.endpoint}"
}
/*output "ns-servers" {
   value = "${aws_route53_zone.unixhatcom.name_servers}"
}*/
