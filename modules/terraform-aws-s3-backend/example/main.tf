# -----------------------------------------------------------------------------
# AMAZON S3 BUCKET - DYNAMODB TABLE TERRAFORM STATE
# -----------------------------------------------------------------------------
provider "aws" {
  region = "us-east-1"
}

module "s3_backend" {
  source         = "../../terraform-aws-s3-backend"
  s3_bucket      = "tf-roxsross-s3-bucket"
  dynamodb_table = "tf-roxsross-dynamodb-table"
}