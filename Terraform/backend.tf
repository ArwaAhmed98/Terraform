terraform {
  backend "s3" {
    bucket= "itisthreee"
    key    = "backend/terraform.tf"
    region = "us-east-1"
    #  dynamodb_table = "terraform-state-lock-dynamo"
  }
}
# backend.tf run only in init command , so we cannot use variables here
#workspace, backend is divided into dev , prod , test