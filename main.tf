provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "hls" {
  bucket = var.bucket == "" ? null : var.bucket
}

resource "aws_s3_bucket_public_access_block" "hls" {
  bucket = aws_s3_bucket.hls.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "allow_public_access" {
  bucket = aws_s3_bucket.hls.id
  policy = data.aws_iam_policy_document.allow_public_access.json

  depends_on = [
    aws_s3_bucket_public_access_block.hls
  ]
}

data "aws_iam_policy_document" "allow_public_access" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions = [
      "s3:GetObject"
    ]
    resources = [
      "${aws_s3_bucket.hls.arn}/*"
    ]
  }
}

resource "aws_s3_bucket_cors_configuration" "hls" {
  bucket = aws_s3_bucket.hls.id

  cors_rule {
    allowed_headers = ["Range"]
    allowed_methods = ["GET"]
    allowed_origins = var.origins
    max_age_seconds = 3000
  }
}
