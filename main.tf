# MAIN
provider "aws" {
  region = "us-west-1"
}

provider "aws" {
  alias  = "source"
  region = "us-west-2"
}