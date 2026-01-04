variable "aws_region" {
    description = "The AWS region to deploy resources in"
    type        = string
    default     = "us-east-1"
}

variable "s3_bucket_names" {
  type        = list(string)
  description = "List of S3 bucket names for count example"
  default     = ["tf-day08-count-bucket-a-20251016", "tf-day08-count-bucket-b-20251016"]
}

variable "s3_for_each_buckets" {
  type        = map(string)
  description = "Map of S3 bucket names for for_each example"
  default     = {
    "bucketA" = "tf-day08-foreach-bucket-a-20251017"
    "bucketB" = "tf-day08-foreach-bucket-b-20251017"
  }
}