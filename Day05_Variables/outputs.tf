output "s3_bucket_name" {
    description = "The name of the S3 bucket"
    value = aws_s3_bucket.test_bucket.bucket
}

output "s3_bucket_tags" {
    description = "The tags of the S3 bucket"
    value = aws_s3_bucket.test_bucket.tags
}