resource "aws_kms_key" "source-kms-key" {
  provider = aws.source
  description             = "This key is used to encrypt bucket objects on source"
  deletion_window_in_days = 10
}

resource "aws_s3_bucket_server_side_encryption_configuration" "source-enc" {
  provider = aws.source
  bucket = aws_s3_bucket.source.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.source-kms-key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_kms_key" "dest-kms-key" {
  provider = aws.dest
  description             = "This key is used to encrypt bucket objects on dest"
  deletion_window_in_days = 10
}

resource "aws_s3_bucket_server_side_encryption_configuration" "dest-enc" {
  provider = aws.dest
  bucket = aws_s3_bucket.destination.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.dest-kms-key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}