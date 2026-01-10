resource "aws_instance" "my_ec32_instance" {
    ami = "ami-0abcdef1234567890"
    instance_type = var.allowed_vm_types[2]


  lifecycle {
    create_before_destroy = true
  }

  tags = merge (
    local.common_tags,
    {
      ManagedBy = var.ManagedBy == "CIS-COE" ? "Project-Cloud-Team" : var.ManagedBy
    }
  )
}