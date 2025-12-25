variable "environment" {
  description = "Resource belongs to Production Environment"
  type = string
}

variable "resource_creator" {
    description = "The creator of the resources"
    type        = string
}

variable "Owner" {
    description = "The owner of the resources"
    type        = string
}

variable "ManagedBy" {
    description = "The manager of the resources"
    type        = string
    default = "CIS-COE"

    validation {
        condition     = contains(["CIS-COE", "Project-Cloud-Team"], var.ManagedBy)
        error_message = "managed_by must be either 'CIS-COE' or 'Project-Cloud-Team'."
    }
}



variable "s3_data_bucket" {
    description = "Complete project assets data bucket"
    type        = string
}