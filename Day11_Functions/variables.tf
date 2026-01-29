variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-west-2"
}

variable "environment" {
  description = "The deployment environment"
  type        = string
  default     = "dev"
}


variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = "My Terraform Project"
}

variable "project_tags" {
  description = "Default tags to apply to all resources"
  type        = map(string)
  default     = {
    Owner       = "DevOps Team"
    Project     = "Terraform Learning"
    Environment = "Development"
  }
}

variable "environment_tags" {
  description = "Environment specific tags"
  type        = map(string)
  default     = {
    Environment = "Dev"
    CostCenter  = "CC1234"
  }
}

variable "allowed_ports" {
    description = "List of allowed ports for security group"
    default = "22, 80, 443, 8080"
}

variable "instace_sizes" {
    default = {
        dev    = "t3.micro"
        stage  = "t2.small"
        prod   = "t2.medium"
    }
}