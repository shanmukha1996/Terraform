provider "aws" {
  profile = "default"
  region  = "eu-west-1"
  version = "<=2.7"
}

locals {
  common_tags = {
    Owner = "DevOps Team"
    service = "backend"
  }
}

resource "aws_instance" "app-dev" {
   ami = "ami-0701e7be9b2a77600"
   instance_type = "t2.micro"
   tags = local.common_tags
}

resource "aws_ebs_volume" "db_ebs" {
  availability_zone = "eu-west-1a"
  size              = 8
  tags = local.common_tags
}