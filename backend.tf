terraform {
  backend "s3" {
    
    bucket= "itisthree"
    key    = "backend/terraform.tf"
    region = "us-east-1"
    #  dynamodb_table = "terraform-state-lock-dynamo"
  }
}
# backend.tf run only in init command , so we cannot use variables here
#workspace, backend is divided into dev , prod , ..


# # Adding S3 bucket as trigger to my lambda and giving the permissions
# resource "aws_s3_bucket_notification" "aws-lambda-trigger" {
#   bucket = aws_s3_bucket.bucket.id
#   lambda_function {
#     lambda_function_arn = aws_lambda_function.test_lambda.arn
#     events              = ["s3:ObjectCreated:*", "s3:ObjectRemoved:*"]

#   }
# }
# resource "aws_lambda_permission" "test" {
#   statement_id  = "AllowS3Invoke"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.test_lambda.function_name
#   principal     = "s3.amazonaws.com"
#   source_arn    = "arn:aws:s3:::${aws_s3_bucket.bucket.id}"
# }