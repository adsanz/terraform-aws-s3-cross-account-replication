resource "aws_s3_bucket" "destination" {
  bucket = var.bucket_dest_name
}

resource "aws_s3_bucket_versioning" "destination" {
  bucket = aws_s3_bucket.destination.id
  versioning_configuration {
    status = var.versioning_enable
  }
}
