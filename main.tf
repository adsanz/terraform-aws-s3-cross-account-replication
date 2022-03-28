# MAIN
provider "aws" {
  alias  = "dest"
  region = "us-west-1"
}

provider "aws" {
  alias  = "source"
  region = "us-west-2"
}