provider "aws" {
  profile = "default"
  region  = "eu-west-1"
  version = "~> 2.7"
}

resource "aws_ecs_cluster" "foo" {
  name = "white-hart"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}