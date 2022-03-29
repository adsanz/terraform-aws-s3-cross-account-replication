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
resource "aws_s3_bucket_public_access_block" "destination" {
  provider = aws.dest
  bucket = aws_s3_bucket.destination.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}