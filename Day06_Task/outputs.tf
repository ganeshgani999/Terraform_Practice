# VPC Outputs
output "vpc_id" {
    description = "The ID of the VPC"
    value       = aws_vpc.main_vpc.id
}

output "vpc_cidr_block" {
    description = "The CIDR block of the VPC"
    value       = aws_vpc.main_vpc.cidr_block
}

output "vpc_arn" {
    description = "The ARN of the VPC"
    value       = aws_vpc.main_vpc.arn
}

# Subnet Outputs
output "public_subnet_ids" {
    description = "List of Public Subnet IDs"
    value       = aws_subnet.public_subnets[*].id
}

output "public_subnet_cidrs" {
    description = "List of Public Subnet CIDR blocks"
    value       = aws_subnet.public_subnets[*].cidr_block
}

# S3 Bucket Outputs

output "application_bucket_name" {
    description = "The name of the application S3 bucket"
    value       = aws_s3_bucket.app_bucket.bucket
}

output "application_bucket_arn" {
    description = "The ARN of the application S3 bucket"
    value       = aws_s3_bucket.app_bucket.arn
}

output "s3_bucket_domain_name" {
    description = "The domain name of the S3 bucket"
    value       = aws_s3_bucket.app_bucket.bucket_domain_name
}

output "Environment" {
    description = "The deployment environment"
    value       = var.environment
}

output "Region" {
    description = "The AWS region where resources are deployed"
    value       = var.region
}

output "common_tags" {
    description = "Common tags applied to resources"
    value       = local.common_tags
}

