# AWS Region Variable

variable "aws_region" {
  description = "The AWS region to deploy resources in."
  type        = string
}

# Environment Variable

variable "environment" {
  description = "Resource belongs to Production Environment"
  type = string
  default = "dev"
}

variable "resource_creator" {
  description = "The creator of the resources"
  type        = string
  default     = "Siva Ganesh"
}


# S3 Bucket Variables

variable "bucket_names" {
  description = "Set of S3 bucket names to be created."
  type        = string
}

# Ec2 Instance Variables

variable "instance_name" {
  description = "List of EC2 instance names to be created."
  type        = list(string)
  default = [ "default_app_server" ]
}

variable "vm_type" {
  description = "List of allowed VM types for deployment."
  default     = [ "t2.micro" ]
}

variable "allowed_zones" {
  description = "List of allowed AWS regions for deployment."
  type        = set(string)
  default     = [ "us-east-1" ]
}

variable "valid_zone" {
  type    = string
  default = "us-east-1"

  validation {
    condition     = contains(var.allowed_zones, var.valid_zone)
    error_message = "Region is not allowed. Allowed regions are us-east-1, us-west-2, eu-west-1."
  }
}


# RDS Variables

variable "db_username" {
  description = "The username for the RDS database."
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "The password for the RDS database."
  type        = string
  sensitive   = true
  default = "admin!456"
}

variable "db_name" {
  description = "The name of the RDS database."
  type        = string
  default     = "app_db"
}

# Tags Variable

variable "Owner" {
    description = "The owner of the resources"
    type        = string
}

variable "resource_creator" {
    description = "The creator of the resources"
    type        = string
    default     = "Siva Ganesh"
}

variable "ManagedBy" {
    description = "Identifies which team manages the resource"
    type        = string
    default = "CIS-COE"

    validation {
        condition     = contains(
            ["CIS-COE", "Project-Cloud-Team"],
            var.ManagedBy
        )
        error_message = "managed_by must be either 'CIS-COE' or 'Project-Cloud-Team'."
    }
}


