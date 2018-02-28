resource "aws_s3_bucket" "public_website" {
  bucket = "${var.domain}"
  acl    = "private"
  website = {
    index_document = "index.html"
    error_document = "index.html"
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