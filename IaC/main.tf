provider "aws" {
  region = "us-east-2"
}

# S3 Bucket
resource "aws_s3_bucket" "mon_bucket" {
  bucket = var.bucket_name
}

# General logging policy for both Lambda functions
resource "aws_iam_policy" "lambda_logging" {
  name = "lambda_logging"
  description = "IAM policy for logging from a lambda"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}