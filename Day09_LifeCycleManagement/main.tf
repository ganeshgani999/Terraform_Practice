# Data Sources

# latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Get current AWS region
data "aws_region" "current" {}

# Get availability zones
data "aws_availability_zones" "available" {
  state = "available"
}


# Example 1: create_before_destroy
# Use Case: EC2 instance that needs zero downtime during updates

resource "aws_instance" "web_server" {
  ami = data.aws_ami.amazon_linux_2.id
  instance_type = var.vm_type

  tags = merge(
    local.common_tags,
    {
      ManagedBy = "Project-Cloud-Team"
      Demo = "Create Before Destroy"
    }
  )

  # Lifecycle Rule: Create new instance before destroying the old one
  # This ensures zero downtime during instance updates (e.g., changing AMI or instance type)
  lifecycle {
    create_before_destroy = true
  }
}


# Example 2: prevent_destroy
# Use Case: Critical S3 bucket that should never be accidentally deleted

resource "aws_s3_bucket" "critical_data" {
  bucket = "${local.bucket_prefix}-critical-data-bucket"

  tags = merge(
    local.common_tags,
    {
      ManagedBy = "Project-Cloud-Team"
      Demo = "Prevent Destroy"
    }
  )

  # Lifecycle Rule: Prevent accidental deletion of this critical bucket
  lifecycle {
    prevent_destroy = true
  }
}

# Enable versioning on the critical bucket
resource "aws_s3_bucket_versioning" "critical_data" {
  bucket = aws_s3_bucket.critical_data.id

  versioning_configuration {
    status = "Enabled"
  }
}