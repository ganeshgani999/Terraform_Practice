resource "aws_instance" "my_ec32_instance" {
    ami = "ami-0a24b0f8452a8736e"
    count = var.instance_count

    # Conditional expression to select instance type based on environment
    instance_type = var.environment == "production" ? var.allowed_vm_types[3] : var.allowed_vm_types[0]

  tags = merge (
    local.common_tags,
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc" "mainvpc" {
  cidr_block = "10.1.0.0/16"
}


resource "aws_security_group" "ingress_rule" {
  name        = "web-sg"
  description = "Security group for web servers"

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      description = ingress.value.description
      from_port = ingress.value.from_port
      to_port   = ingress.value.to_port
      protocol  = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}