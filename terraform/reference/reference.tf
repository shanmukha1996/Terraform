# Cross account resource attributes
provider "aws" {
  profile = "default"
  region  = "eu-west-1"
  version = "2.7"
}

resource "aws_instance" "example" {
  ami           = "ami-0701e7be9b2a77600"
  instance_type = "t2.micro"

  tags = {
    Name = "Terraform2"
  }

}

resource "aws_eip" "ip" {
    vpc = true
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.example.id
  allocation_id = aws_eip.ip.id
}

resource "aws_security_group" "allow_tls" {
  name        = "my-security-group"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${aws_eip.ip.public_ip}/32"]

  }
}



