resource "aws_s3_bucket" "destination" {
  provider = aws.dest
  bucket = var.bucket_dest_name
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "destination" {
  provider = aws.dest
  bucket = aws_s3_bucket.destination.id
  versioning_configuration {
    status = var.versioning_enable
  }
}