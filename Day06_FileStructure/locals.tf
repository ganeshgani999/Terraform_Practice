locals {
    Managed_by_value = var.ManagedBy == "CIS-COE" ? "CIS-COE" : "Project-Cloud-Team"
    
    common_tags = {
        Environment = var.environment
        CreatedBy   = var.resource_creator
        Owner       = var.Owner
        ManagedBy   = local.Managed_by_value
    }

    data_bucket_name = "${var.s3_data_bucket}-${var.environment}-${random_string.suffix.result}"
}

resource "random_string" "suffix" {
    length  = 6
    upper   = false
    lower   = true
    numeric = true
    special = false
}