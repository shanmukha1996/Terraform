provider "aws" {
  profile = "default"
  region  = "eu-west-1"
  version = "<=2.7"
}

resource "aws_iam_user" "lb" {
	name = "loadbalancer.${count.index}"
	count = 5
}