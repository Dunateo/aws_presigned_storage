
# Première Lambda nom de la ressources dans terrraform
resource "aws_lambda_function" "lambda_upload" {
  filename      = "./lambdaFileUploads.zip"
  function_name = "lambda-upload"
  role          = aws_iam_role.lambda_role_upload.arn
  handler       = "lambdaFileUploads.lambda_handler"
  runtime       = "python3.13"

  environment {
    variables = {
      BUCKET_NAME = aws_s3_bucket.mon_bucket.id
    }
  }
}

# Attaching the generic policy
resource "aws_iam_role_policy_attachment" "lambda_logs_upload" {
  role       = aws_iam_role.lambda_role_upload.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}

# Creation of an IAM Role and S3 Access Policy
resource "aws_iam_role" "lambda_role_upload" {
  name = "lambda_role_upload"

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

resource "aws_iam_role_policy" "lambda_s3_upload" {
  name = "lambda_s3_upload"
  role = aws_iam_role.lambda_role_upload.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "s3:PutObject"
        Resource = [
          aws_s3_bucket.mon_bucket.arn,
          "${aws_s3_bucket.mon_bucket.arn}/*"
        ]
      }
    ]
  })
}