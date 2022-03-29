resource "aws_iam_role" "replication" {
  provider = aws.source
  name = var.replication_role_name

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

resource "aws_iam_policy" "replication" {
  provider = aws.source
  name = var.replication_policy_name

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetReplicationConfiguration",
        "s3:ListBucket"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.source.arn}"
      ]
    },
    {
      "Action": [
        "s3:GetObjectVersionForReplication",
        "s3:GetObjectVersionAcl",
         "s3:GetObjectVersionTagging"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.source.arn}/*"
      ]
    },
    {
      "Action": [
        "s3:ReplicateObject",
        "s3:ReplicateDelete",
        "s3:ReplicateTags"
      ],
      "Effect": "Allow",
      "Resource": "${aws_s3_bucket.destination.arn}/*"
    },
    {
			"Action": ["kms:Decrypt"],
			"Effect": "Allow",
			"Resource": [
        "${aws_kms_key.dest-kms-key.arn}",
        "${aws_kms_key.source-kms-key.arn}"
      ],
			"Condition": {
				"StringLike": {
					"kms:EncryptionContext:aws:s3:arn": "arn:aws:s3:::${var.bucket_source_name}/*"
				}
			}
		},
		{
			"Action": ["kms:Encrypt"],
			"Effect": "Allow",
			"Resource": "${aws_kms_key.dest-kms-key.arn}",
			"Condition": {
				"StringLike": {
					"kms:EncryptionContext:aws:s3:arn": "arn:aws:s3:::${var.bucket_dest_name}/*"
				}
			}
		}
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "replication" {
  provider = aws.source
  role       = aws_iam_role.replication.name
  policy_arn = aws_iam_policy.replication.arn
}