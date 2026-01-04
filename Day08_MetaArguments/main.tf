resource "aws_s3_bucket" "my_bucket" {
    count = length(var.s3_bucket_names)

    bucket = var.s3_bucket_names[count.index]
    
    tags = {
        Name        = "MyBucket"
        Environment = "Dev"
        Owner       = "TeamA"
    }
}

resource "aws_s3_bucket" "my_for_each_bucket" {
    for_each = var.s3_for_each_buckets
    bucket = each.value
    tags = {
        Name        = "MyForEachBucket"
        Environment = "Dev"
        Owner       = "TeamB"
    }
}