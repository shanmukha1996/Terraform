provider "aws" {
  profile = "default"
  region  = "eu-west-1"
  version = "~> 2.7"
}

resource "aws_instance" "example" {
  ami           = "ami-0701e7be9b2a77600"
  instance_type = "t2.micro"

  tags = {
    Name = "Terraform1"
  }

  depends_on = [aws_s3_bucket.example]

  provisioner "local-exec" {
    command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
  }
}

resource "aws_eip" "ip" {
    vpc = true
    instance = aws_instance.example.id
}


output "eip" {
  value = aws_eip.ip
}

resource "aws_s3_bucket" "example" {
  bucket = "psspavanhanu"
  acl    = "private"
}

output "mys3bucket" {
  value = aws_s3_bucket.example
}
