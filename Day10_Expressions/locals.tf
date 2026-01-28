locals {
    common_tags = tomap({
        Environment = var.environment
        CreatedBy   = var.resource_creator
        Owner       = var.Owner
        ManagedBy   = var.ManagedBy
    })

    # splat expression to get all instance IDs
    all_insatnces_ids = aws_instance.my_ec32_instance[*].id
}

output "instances" {
    value =  local.all_insatnces_ids
}


