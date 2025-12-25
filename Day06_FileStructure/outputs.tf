output "asset_bucket" {
    description = "The name of the S3 bucket created for project assets"
    value = {
        bucket_name = aws_s3_bucket.asset_bucket.bucket
        tags = aws_s3_bucket.asset_bucket.tags
    }
}

output "web_server_details" {
    description = "The ID of the web server EC2 instance"
    value = {
        id = aws_instance.web_server.id
        public_ip = aws_instance.web_server.public_ip
        private_ip = aws_instance.web_server.private_ip
        storage_size = aws_instance.web_server.root_block_device[0].volume_size
        tags = aws_instance.web_server.tags
    }
}