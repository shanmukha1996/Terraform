provider "aws" {
  profile = "default"
  region  = "eu-west-1"
  version = "<=2.7"
}

resource "aws_instance" "example" {
  ami           = "ami-0701e7be9b2a77600"
  instance_type = var.instancetype

  tags = {
    Name = "Terraform"
  }

}