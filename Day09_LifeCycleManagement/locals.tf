locals {
    common_tags = tomap({
        Project     = "Terraform_LifeCycle_Management"
        Environment = var.environment
        CreatedBy   = var.resource_creator
        Owner       = var.Owner
    })

    bucket_prefix = "${var.environment}"

    env_config = {
        dev = {
            instance_type = "t2.micro"
            multi_az      = false
        }
        staging = {
            instance_type = "t2.small"
            multi_az      = false
        }
        prod = {
            instance_type = "t3.medium"
            multi_az      = true
        }
    }

}
