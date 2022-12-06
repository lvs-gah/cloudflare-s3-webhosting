## S3 bucket for www_website.

resource "aws_s3_bucket" "bucket" {
  bucket = "${var.domain_bucket}"
  object_lock_enabled = false

  website {
    index_document = "index.html"
    error_document = "404.html"
  }
  versioning {
    enabled = false
  }
}

## S3 Bucket Policy bucket
resource "aws_s3_bucket_policy" "bucket" {
  bucket = aws_s3_bucket.bucket.id
  policy = templatefile("${path.module}/policies/s3_bucket_policy.json",{
    DOMAIN_BUCKET = var.domain_bucket
  })
}

## S3 Bucket ownership bucket
resource "aws_s3_bucket_ownership_controls" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

## S3 Bucket public access bucket
resource "aws_s3_bucket_public_access_block" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
 
## Turn off Verisoning
resource "aws_s3_bucket_versioning" "bucket" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Disabled"
  }
}