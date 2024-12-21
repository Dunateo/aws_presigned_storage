# Files containing all variables for better readability

variable "bucket_name" {
  description = "S3 Bucket Name"
  default     = "pag-bucket-terraform"
}

variable "service_account_user_name" {
  description = "IAM User Name for Service Account"
  type        = string
  default     = "Pag"
}