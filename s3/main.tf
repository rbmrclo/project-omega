resource "aws_s3_bucket" "public_website_log" {
  bucket = "${var.domain}-log"
  acl    = "log-delivery-write"
}

# Used for versioning testing
resource "aws_s3_bucket" "public_website_versioning" {
  bucket = "${var.domain}-versions"
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    prefix  = "config/"
    enabled = true

    noncurrent_version_transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    noncurrent_version_transition {
      days          = 60
      storage_class = "GLACIER"
    }

    noncurrent_version_expiration {
      days = 90
    }
  }
}

resource "aws_s3_bucket" "public_website" {
  bucket = "${var.domain}"
  acl    = "private"
  website = {
    index_document = "index.html"
    error_document = "index.html"
  }

  logging {
    target_bucket = "${aws_s3_bucket.public_website_log.id}"
    target_prefix = "log/"
  }

  versioning {
    enabled = true
  }
}



resource "aws_s3_bucket_policy" "public_website" {
  bucket = "${aws_s3_bucket.public_website.id}"
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AddPerm",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${var.domain}/*"
    }
  ]
}
POLICY
}
