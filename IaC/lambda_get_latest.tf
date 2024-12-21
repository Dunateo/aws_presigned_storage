# Lambda to retrieve the latest file from the bucket
resource "aws_lambda_function" "lambda_get_latest" {
  filename      = "./lambdaGetlastFile.zip"
  function_name = "lambda-get-latest"
  role          = aws_iam_role.lambda_role_get_latest.arn
  handler       = "lambdaGetlastFile.lambda_handler"
  runtime       = "python3.13"

  environment {
    variables = {
      BUCKET_NAME = aws_s3_bucket.mon_bucket.id
    }
  }
}

# Attaching the generic policy
resource "aws_iam_role_policy_attachment" "lambda_logs_get_latest" {
  role       = aws_iam_role.lambda_role_get_latest.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}

# Creation of an IAM Role and S3 Access Policy
resource "aws_iam_role" "lambda_role_get_latest" {
  name = "lambda_role_get_latest"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "lambda_s3" {
  name = "lambda_s3"
  role = aws_iam_role.lambda_role_get_latest.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.mon_bucket.arn,
          "${aws_s3_bucket.mon_bucket.arn}/*"
        ]
      }
    ]
  })
}