output "s3_bucket_name" {
  value = aws_s3_bucket.mon_bucket.id
}

output "lambda_upload_arn" {
  value = aws_lambda_function.lambda_upload.arn
}

output "lambda_get_latest_arn" {
  value = aws_lambda_function.lambda_get_latest.arn
}