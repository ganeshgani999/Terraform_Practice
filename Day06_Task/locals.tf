locals {

    managedBy = var.managedBy == "CIS-COE" ? "CIS-COE" : "Project-Cloud-Team"

    common_tags = merge(var.tags, {
        Project = var.project_name
        Environment = var.environment
        Owner = var.owner
        CreatorBy = var.createdBy
        CreatedDate = formatdate("YYYY-MM-DD", timestamp())
        ManagedBy = local.managedBy
    })

    name_prifix = "${var.project_name}-${var.environment}"

    vpc_name = "${local.name_prifix}-vpc"

    bucket_name = "${local.name_prifix}-${random_id.bucket_suffix.hex}"

}

resource "random_id" "bucket_suffix" {
        
        byte_length = 5
        keepers = {
        project = var.project_name
        environment = var.environment
    }
}