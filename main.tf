# MAIN

provider "aws" {
  alias = "source"
  region = "us-west-2"
}

provider "aws" {
  alias = "dest"
  region = "us-west-1"
}

data "aws_caller_identity" "source" {
  provider = aws.source
}

data "aws_caller_identity" "dest" {
  provider = aws.dest
}
