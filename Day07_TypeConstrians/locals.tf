locals {

    common_tags = tomap({
        Environment = var.environment
        CreatedBy   = var.resource_creator
        Owner       = var.Owner
    })

    data_bucket_name = "${var.s3_data_bucket}-${var.environment}-${random_string.suffix.result}"
}

resource "random_string" "suffix" {
    length  = 6
    upper   = false
    lower   = true
    numeric = true
    special = false
}