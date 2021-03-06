variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  default = "ap-southeast-1"
}
variable "AMIS" {
  type = "map"
  default = {
    ap-southeast-1 = "ami-03a31060"
    ap-southeast-2 = "ami-2de5e74e"
  }
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}
variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}
variable "INSTANCE_DEVICE_NAME" {
  default = "/dev/xvdh"
}
variable "RDS_PASSWORD" { 
  default = "6rarEvui89"
}
#variable "RDS_PASSWORD" {}
