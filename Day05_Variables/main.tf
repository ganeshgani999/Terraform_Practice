resource "aws_s3_bucket" "test_bucket" {
    bucket = local.test_bucket_name

    tags = local.common_tags
}