resource "aws_s3_bucket" "asset_bucket" {
    bucket = local.data_bucket_name
    tags = merge(
        local.common_tags,
        {
            resource_type = "s3_bucket"
            ManagedBy     = var.ManagedBy
        }
    )
}


resource "aws_instance" "web_server" {
    count = var.instance_count
    ami = "resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
    instance_type = var.allowed_vm_types[0]
    availability_zone = tolist(var.allowed_availability_zones)[3]
    monitoring = var.monitoring_enabled
    associate_public_ip_address = var.associate_public_ip_address_enabled

    tags = merge(
        local.common_tags,
        var.ec2_resource_tags,
        {
            ManagedBy = var.ManagedBy == "CIS-COE" ? "Project-Cloud-Team" : var.ManagedBy
        }
    )
}

# Security Group to allow inbound TLS and all outbound traffic

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = var.cidr_block[0]
  from_port         = var.ingress_values[0]
  ip_protocol       = var.ingress_values[1]
  to_port           = var.ingress_values[2] 
}



resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}


