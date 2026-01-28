variable "aws_region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "us-east-1"
}

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

variable "allowed_vm_types" {
  description = "List of allowed VM types for deployment."
  type        = list(string)
  default     = ["t2.micro", "t2.small", "t3.micro", "t3.small"]
}

variable "allowed_availability_zones" {
  description = "List of allowed AWS regions for deployment."
  type        = set(string)
  default     = ["us-east-1", "us-west-2", "eu-west-1"]
}

variable "region" {
  type    = string
  default = "us-east-1"

  validation {
    condition     = contains(var.allowed_availability_zones, var.region)
    error_message = "Region is not allowed. Allowed regions are us-east-1, us-west-2, eu-west-1."
  }
}

variable "instance_count" {
  description = "Number of EC2 instances to create."
  type        = number
}


#ingress rules variable[] = [object1, object2,...]
variable "ingress_rules" {
  description = "List of ingress rules for security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  default = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "HTTP"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "HTTPS"
    }
  ]
}