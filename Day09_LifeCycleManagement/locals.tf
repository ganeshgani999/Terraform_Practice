locals {

    common_tags = tomap({
        Environment = var.environment
        CreatedBy   = var.resource_creator
        Owner       = var.Owner
    })

}
