provider "aws" {
  profile = "default"
  region  = "eu-west-1"
  version = "<=2.7"
}

variable "istest" {}

resource "aws_instance" "dev" {
   ami = "ami-0701e7be9b2a77600"
   instance_type = "t2.micro"
   count = var.istest == true ? 3 : 0
}

resource "aws_instance" "prod" {
   ami = "ami-0701e7be9b2a77600"
   instance_type = "t2.micro"
   count = var.istest == false ? 1 : 0
}