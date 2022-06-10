provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
  # region = var.region
  profile="dev" # deal with the dev credentials in ~/.aws/credentials
}