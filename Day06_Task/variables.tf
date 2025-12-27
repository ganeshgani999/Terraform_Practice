variable "project_name" {
    description = "The name of the project"
    type        = string
}

variable "environment" {
    description = "Resource belongs to Production Environment"
    type        = string

    validation {
      condition = contains(["dev", "staging", "production"], var.environment)
      error_message = "Environment must be dev, staging, production"
    }
}

variable "region" {
    description = "The AWS region to deploy resources in"
    type        = string
}

variable "owner" {
    description = "Owner of the resources"
    type        = string
}

variable "createdBy" {
    description = "Creator of the resources"
    type        = string
}

variable "managedBy" {
    description = "Indicates who is managing the resources"
    type        = string
    default     = "CIS-COE"

    validation {
      condition = contains(["CIS-COE", "Project-Cloud-Team"], var.managedBy)
      error_message = "managedBy must be either 'CIS-COE' or 'Project-Cloud-Team'."
    }
}


variable "vpc_cidr" {
    description = "CIDR block for the VPC"
    type        = string
    default     = "10.0.0.0/16"

    validation {
      condition = can(cidrhost(var.vpc_cidr, 0))
      error_message = "VPC CIDR must be a valid IPV4 address"
    }
}

variable "availability_zones" {
    description = "List of availability zones to use"
    type        = list(string)
    default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "tags" {
    description = "Additional tags applied to resources"
    type        = map(string)
    default     = {}
}


