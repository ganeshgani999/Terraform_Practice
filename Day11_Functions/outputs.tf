output "Formatted_Project_Name" {
    value = local.formatted_project_name
}

output "Bucket_Tags" {
    value = aws_s3_bucket.firsts3bucket.tags
}

output "Bucket_Name" {
    value = aws_s3_bucket.firsts3bucket.bucket
}

output "ports_list" {
    value = local.ports_list
}

output "Security_Group_Rules" {
    value = local.sg_rules
}

output "instance_size" {
    value = local.instance_size
}