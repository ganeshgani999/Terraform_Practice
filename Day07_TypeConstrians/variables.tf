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

variable "ec2_resource_tags" {
    description = "Tags to be applied to all resources"
    type        = map(string)
    default     = {
        resource_type = "ec2_instance"
    }
}

variable "s3_data_bucket" {
    description = "Complete project assets data bucket"
    type        = string
}

variable "instance_count" {
    description = "Number of EC2 instances to create"
    type        = number
    default     = 1

    validation {
        condition     = var.instance_count > 0 && var.instance_count <= 5
        error_message = "instance_count must be between 1 and 3."
    }
}

variable monitoring_enabled {
    description = "Enable detailed monitoring for EC2 instances"
    type        = bool
    default     = true
}

variable "associate_public_ip_address_enabled" {
    description = "Associate public IP address with EC2 instances"
    type        = bool
    default     = true
}

# Security Group to allow inbound TLS and all outbound traffic

variable "cidr_block" {
    description = "The CIDR block for the VPC"
    type        = list(string)
    default     = ["10.0.0.0/8", "192.168.0.0/16", "192.168.0.0/21"]
  
}


variable "allowed_vm_types" {
    description = "List of allowed VM instance types"
    type        = list(string)
    default     = ["t2.micro", "t3.micro", "t3a.micro", "t4g.micro"]
}


variable "allowed_availability_zones" {
    description = "List of allowed AWS regions"
    type        = set(string)
    default     = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"]
}

variable "ingress_values" {
    description = "List of allowed ingress port values"
    type        = tuple([number, string, number])
    default     = [22, "tcp", 443]
}