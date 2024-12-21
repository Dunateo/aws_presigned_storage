# Define IAM policy for Lambda execution permissions
data "aws_iam_policy_document" "service_account_policy" {
  statement {
    effect = "Allow"
    actions = [
      "lambda:InvokeFunction"
    ]
    resources = [
      aws_lambda_function.lambda_upload.arn,
      aws_lambda_function.lambda_get_latest.arn
    ]
  }
}

resource "aws_iam_policy" "service_account_policy" {
  name        = "service-account-policy"
  path        = "/"
  description = "Policy for service account"
  policy      = data.aws_iam_policy_document.service_account_policy.json
}

resource "aws_iam_user_policy_attachment" "service_account_policy_attachment" {
  user       = var.service_account_user_name
  policy_arn = aws_iam_policy.service_account_policy.arn
}