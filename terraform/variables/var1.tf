provider "aws" {
  profile = "default"
  region  = "eu-west-1"
  version = "2.7"
}

resource "aws_instance" "example" {
  ami           = "ami-0701e7be9b2a77600"
  instance_type = "t2.micro"

  tags = {
    Name = "Terraform"
  }

}

resource "aws_eip" "ip" {
    vpc = true
}


resource "aws_security_group" "allow_tls" {
  name        = "my-security-group"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpn_ip]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.vpn_ip]
  }

  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = [var.vpn_ip]
  }
}



