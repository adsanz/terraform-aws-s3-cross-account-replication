# MAIN

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">=4.8.0"
      configuration_aliases = [ aws.source, aws.dest ]
    }
  }
}