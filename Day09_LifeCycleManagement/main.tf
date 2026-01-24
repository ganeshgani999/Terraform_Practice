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
  bucket = "${local.bucket_prefix}-critical-${var.bucket_name}"

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

# ==============================
# Example 3: ignore_changes
# Use Case: Auto Scaling Group where capacity is managed externally
# ==============================

# Launch Template for Auto Scaling Group
#Error: instance_type expects a single string, but you defined vm_type as a list and accessed it with [0]; 
#Fix: define vm_type as type = string (with validation if needed) and pass it directly to instance_type.
resource "aws_launch_template" "app_server" {
  name_prefix   = "app-server-"
  image_id      = data.aws_ami.amazon_linux_2.id
  instance_type = var.vm_type

  tag_specifications {
    resource_type = "instance"
    tags = merge(
      local.common_tags,
      {
        Name = "App Server from ASG"
        Demo = "ignore_changes"
      }
    )
  }
}

resource "aws_autoscaling_group" "asg" {
  name = "EC2-AGS-${var.environment}"
  max_size = 2
  min_size = 1
  desired_capacity = 1
  health_check_type         = "EC2"

  availability_zones = data.aws_availability_zones.available.names

  launch_template {
    id      = aws_launch_template.app_server.id
    version = "$Latest"
  }

  dynamic "tag" {
    for_each = local.common_tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  lifecycle {
    ignore_changes = [ desired_capacity ]
  }
}

# ==============================
# Example 4: precondition
# Use Case: Ensure we're deploying in an allowed region
# ==============================

resource "aws_s3_bucket" "regional_bucket" {
  bucket = "validated-regional-bucket-${var.environment}-${var.bucket_name}"

  tags = merge(
    local.common_tags,
    {
      ManagedBy = "Project-Cloud-Team"
      Demo = "Precondition"
    }
  )

  lifecycle {
    precondition {
      condition = contains(var.allowed_zones, data.aws_region.current.name)
      error_message = "ERROR: This resource can only be created in allowed regions: ${join(", ", var.allowed_zones)}. Current region: ${data.aws_region.current.name}"
    }

    postcondition {
      condition = contains(keys(self.tags_all), "ManagedBy")
      error_message = "ERROR: Bucket must contain the 'ManagedBy' tag for ownership tracking."
    }

    postcondition {
      condition = contains(keys(self.tags_all), "Compliance")
      error_message = "ERROR: Bucket must have a 'Compliance' tag for audit purposes!"
    }
  }
}


