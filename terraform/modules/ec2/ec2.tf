provider "aws" {
  profile = "default"
  region  = "eu-west-1"
  version = "<=2.7"
}
resource "aws_instance" "myec2" {
   ami = "ami-089cc16f7f08c4457"
   instance_type = "t2.micro"
}
