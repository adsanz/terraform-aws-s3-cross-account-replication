# MAIN

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">=3.42.0"
      configuration_aliases = [ aws.source, aws.dest ]
    }
  }
}