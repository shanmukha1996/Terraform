terraform {
  backend "s3" {
    bucket = "my-backend"
    key    = "remote.tfstate"
    region = "eu-west-1"
  }
}