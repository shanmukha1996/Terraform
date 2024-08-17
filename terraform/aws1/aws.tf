provider "aws" {
  profile = "default"
  region  = "eu-west-1"
  version = "~> 2.7"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0a8e758f5e873d1c1"
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleAppServerInstance"
  }
}

resource "aws_eip" "ip" {
    vpc = true
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.app_server.id
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

resource "aws_elb" "bar" {
  name               = "Myterraform-elb"
  availability_zones = ["eu-west-1"]

  access_logs {
    bucket = "mybucket199628"
  }

  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  listener {
    instance_port      = 8000
    instance_protocol  = "http"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = "arn:aws:acm:eu-west-1:318300607610:certificate/c998357a-00d9-4cf2-a569-190746e2bc16"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }

  instances                   = [aws_instance.app_server.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "Myterraform-elb"
  }
}