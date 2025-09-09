resource "aws_s3_bucket" "tf_backend_bucket" {
    bucket = var.tf_backend_bucket
      
    tags = {
        Name        = var.tf_backend_bucket
        Environment = var.env
    }
}

resource "aws_s3_bucket_versioning" "tf_backend_bucket_versioning" {
  bucket = aws_s3_bucket.tf_backend_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_object_lock_configuration" "tf_backend_bucket_lock" {
  bucket = aws_s3_bucket.tf_backend_bucket.id

  rule {
    default_retention {
      mode = "COMPLIANCE"
      days = 5
    }
  }
}

# resource "aws_s3_bucket" "example" {
#   bucket = "mybucket"
# }

# resource "aws_s3_bucket_versioning" "example" {
#   bucket = aws_s3_bucket.example.id

#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# resource "aws_s3_bucket_object_lock_configuration" "example" {
#   bucket = aws_s3_bucket.example.id

#   rule {
#     default_retention {
#       mode = "COMPLIANCE"
#       days = 5
#     }
#   }
# }