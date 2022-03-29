# terraform-aws-s3-cross-region-replication
Terraform Module for managing s3 bucket cross-region replication.
----------------------

## What this module does
Set-up 2 buckets with replication with:
- Versioning enabled (required for replication)
- Lifecycle set-up by default with 30 days for STANDARD_IA and 90 days for GLACIER (for the replication, storage class is already GLACIER)
- Encryption with KMS keys
- Both buckets will be private by default



## Required

- AWS provider >= 4.8
- Terraform 1.1.7 module provider inheritance block:

- `aws.source` - AWS provider alias for source account
- `aws.dest`   - AWS provider alias for destination account

### Variables

You can see description of each variable on `variables.tf` file. The ones that does not have a default value, are required. 

### Usage (with all required variables)
-----

```hcl

module "s3-cross-account-replication" {
  source             = "github.com/adsanz/terraform-aws-s3-cross-account-replication?ref=1.0.0"
  bucket_source_name = var.bucket_source_name
  bucket_dest_name   = var.bucket_dest_name
  replication_name   = var.replication_name
  versioning_enable  = var.versioning_enable
  replication_policy_name = var.replication_policy_name
  replication_role_name = var.replication_role_name
  replication_prefix = var.replication_prefix
  source_region = var.source_region
  dest_region = var.dest_region

  providers = {
    aws.source = aws.source
    aws.dest   = aws.dest
  }
}
provider "aws" {
  alias  = "source"
  region = "us-west-2"
  profile = "your-profile"
}


provider "aws" {
  alias  = "dest"
  region = "us-west-1"
  profile = "your-profile"
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
