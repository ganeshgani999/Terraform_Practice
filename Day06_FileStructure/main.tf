resource "aws_s3_bucket" "asset_bucket" {
    bucket = local.data_bucket_name
    tags = merge(
        local.common_tags,
        {
            resource_type = "s3_bucket"
        }
    )
}


resource "aws_instance" "web_server" {
    ami = "resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
    instance_type = "t3.micro"
    tags = merge(
        local.common_tags,
        {
            ManagedBy = var.Owner
            resource_type = "ec2_instance"
        }
    )
}

