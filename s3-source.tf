resource "aws_s3_bucket" "source" {
  provider = aws.source
  bucket   = var.bucket_source_name
  force_destroy = true
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
      delete_marker_replication {
        status = "Enabled"
      }
    source_selection_criteria {
      replica_modifications {
        status = "Enabled"
      }
      sse_kms_encrypted_objects {
        status = "Enabled"
      }
    }
    filter {
      prefix = var.replicate_prefix
    }

    status = "Enabled"

    destination {
      bucket        = aws_s3_bucket.destination.arn
      storage_class = var.destination_storage_class
      encryption_configuration {
        replica_kms_key_id = aws_kms_key.dest-kms-key.arn
      }
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "lifecycle-config" {
  provider = aws.source
  bucket = aws_s3_bucket.source.bucket

  rule {
    id = var.source_lifecycle_name
    status = "Enabled"
    transition {
      days          = var.transition_to_ia
      storage_class = "STANDARD_IA"
    }
    transition {
      days          = var.transition_to_glacier
      storage_class = "GLACIER"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "source" {
  provider = aws.source
  bucket = aws_s3_bucket.source.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}