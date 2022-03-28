resource "aws_s3_bucket" "source" {
  provider = aws.source
  bucket   = var.bucket_source_name
}

resource "aws_s3_bucket_acl" "source_bucket_acl" {
  provider = aws.source

  bucket = aws_s3_bucket.source.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "source" {
  provider = aws.source

  bucket = aws_s3_bucket.source.id
  versioning_configuration {
    status = var.versioning_enable
  }
}

resource "aws_s3_bucket_replication_configuration" "replication" {
  provider = aws.source
  # Must have bucket versioning enabled first
  depends_on = [aws_s3_bucket_versioning.source]

  role   = aws_iam_role.replication.arn
  bucket = aws_s3_bucket.source.id

  rule {
    id = var.replication_name

    filter {
      prefix = var.replicate_prefix
    }

    status = "Enabled"

    destination {
      bucket        = aws_s3_bucket.destination.arn
      storage_class = "STANDARD"
    }
  }
}