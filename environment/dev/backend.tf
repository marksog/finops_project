terraform {
  backend "s3" {
    bucket         = "dev-marksog-finops-backend-data"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "dev-finops-dynamo-table"
    encrypt        = true
  }
}