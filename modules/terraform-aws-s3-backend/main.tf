# -----------------------------------------------------------------------------
# 
#AMAZON S3 BUCKET AND DYNAMODB TABLE FOR STORING TERRAFORM STATE
# This Terraform module deploys the resources necessary to store Terraform
# state on AWS.
# It includes:
#   * Amazon S3 Bucket
#   * DynamoDB Table
# -----------------------------------------------------------------------------

terraform {
  required_version = ">= 1.0.0"
}

# -----------------------------------------------------------------------------
# S3 BUCKET
# 
# -----------------------------------------------------------------------------
resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.s3_bucket

  # Owner gets FULL_CONTROL. No one else has access rights (default).
  acl = "private"

  versioning {
    enabled = true
  }
  
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
#Prevenimos explícitamente la destrucción usando terraform. true|false
  lifecycle {
    prevent_destroy = false
  }
}

# -----------------------------------------------------------------------------
# DYNAMODB TABLE
# 
# -----------------------------------------------------------------------------
resource "aws_dynamodb_table" "dynamodb_table" {
  name = var.dynamodb_table
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  point_in_time_recovery {
    enabled = true
  }
  server_side_encryption {
    enabled     = true
    kms_key_arn = "alias/roxsross/aws/dynamodb"
  }
}