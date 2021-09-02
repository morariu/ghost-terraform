## Specifies the Region your Terraform Provider will server
provider "aws" {
  region = "eu-central-1"
}
## S3 Bucket and DynamoDB table used for state files

terraform {
    backend "s3" {
      encrypt = true
      bucket = "laur-ghost"
      dynamodb_table = "terraform-statefiles-lock"
      key = "terraform.tfstate"
      region = "eu-central-1"
  }
}