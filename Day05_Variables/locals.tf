locals {
    common_tags = {
        Environment = var.test_environment
        CreatedBy   = var.resource_creator
        Owner = var.test_environment_owner
        ManagedBy   = var.resource_creator
    }

    test_bucket_name = "${var.s3_bucket_name}-${var.test_environment}-${random_string.suffix.result}"
}

resource "random_string" "suffix" {
    length  = 6
    upper   = false
    lower   = true
    numeric = true
    special = false
}
