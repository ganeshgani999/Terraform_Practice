variable "test_environment" {
    description = "The environment for resource tagging"
    type        = string
}

variable "resource_creator" {
    description = "The creator of the resources"
    type        = string
}

variable "test_environment_owner" {
    description = "The owner of the resources"
    type        = string
}

variable "s3_bucket_name" {
    description = "The name of the S3 bucket"
    type        = string
}

