
resource "aws_s3_bucket_server_side_encryption_configuration" "s3-dest" {
  bucket = aws_s3_bucket.mybucket.dest

  rule {
    apply_server_side_encryption_by_default {
      #kms_master_key_id = aws_kms_key.mykey.arn
      sse_algorithm     = "AES256"
    }
  }
}


resource "aws_s3_bucket_server_side_encryption_configuration" "s3-source" {
  bucket = aws_s3_bucket.mybucket.source

  rule {
    apply_server_side_encryption_by_default {
      #kms_master_key_id = aws_kms_key.mykey.arn
      sse_algorithm     = "AES256"
    }
  }
}