resource "aws_s3_bucket" "firsts3bucket" {
    bucket = "${local.formatted_bucket_name}"

    tags = merge(
        local.common_tags,
        {
            Name = "${local.formatted_project_name}-bucket"
        }
    )
}

