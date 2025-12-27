resource "aws_s3_bucket" "app_bucket" {
    bucket = "${local.name_prifix}-app-bucket"

    tags = merge(local.common_tags, {
        Name = "${local.name_prifix}-app-bucket"
        Purpose = "Application Storage"
    })
}

resource "aws_s3_bucket_versioning" "app_bucket_versioning" {
    bucket = aws_s3_bucket.app_bucket.id
    versioning_configuration {
        status = "Enabled"
    }   
}

resource "aws_s3_bucket_server_side_encryption_configuration" "app_bucket_encryption" {
    bucket = aws_s3_bucket.app_bucket.id

    rule {
        apply_server_side_encryption_by_default {
            sse_algorithm = "AES256"
        }
        bucket_key_enabled = true
    }
  
}

resource "aws_s3_bucket_public_access_block" "app_bucket_public_access" {
    bucket = aws_s3_bucket.app_bucket.id

    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
}