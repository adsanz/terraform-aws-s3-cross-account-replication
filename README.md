# terraform-aws-s3-cross-account-replication
Terraform Module for managing s3 bucket cross-account cross-region replication.

----------------------

#### Required

All variables set-up on variables.tf are required!. `versioning_enable` is set to "Enabled" by default since is required. 

- Terraform 1.0 module provider inheritance block:

- `aws.source` - AWS provider alias for source account
- `aws.dest`   - AWS provider alias for destination account

Usage
-----

```hcl

module "s3-cross-account-replication" {
  source             = "github.com/adsanz/terraform-aws-s3-cross-account-replication?ref=master"
  bucket_source_name = var.bucket_source_name
  bucket_dest_name   = var.bucket_dest_name
  replication_name   = var.replication_name
  versioning_enable  = var.versioning_enable
  replication_policy_name = var.replication_policy_name
  replication_role_name = var.replication_role_name
  replication_prefix = var.replication_prefix

  providers = {
    aws.source = aws.source
    aws.dest   = aws.dest
  }
}
provider "aws" {
  alias  = "source"
  region = "us-west-2"
  profile = "leo"
}


provider "aws" {
  alias  = "dest"
  region = "us-west-1"
  profile = "leo"
}



```

Authors
=======

* [John Noss](https://github.com/jnoss)
* Updated by [AdSanz](https://github.com/adsanz)


Changelog
=========

1.0.0 - Initial release.

License
=======

This software is released under the MIT License (see `LICENSE`).
