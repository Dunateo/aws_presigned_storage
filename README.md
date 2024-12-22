# aws_presigned_storage
AWS Presigned URL Serverless S3 Upload and Retrieve

Project demonstrates how to implement a serverless solution for uploading and retrieving data from Amazon S3 using presigned URLs. 
It includes examples of triggering AWS Lambda functions with Python and deploying the infrastructure using Terraform. 


## Prerequisites

- AWS account with appropriate permissions "Pag"
- AWS CLI configured with your credentials
- Python 3.8 or later
- Terraform 0.12 or later


## Setup

- Update the terraform.tfvars file with your desired configuration.

- Initialize Terraform:
````Bash
terraform init
terraform plan
````

- Deploy the infrastructure:
````Bash
terraform apply
````



## Security Considerations

- Ensure that your S3 bucket has appropriate access controls
- Use IAM roles with least privilege principles
- Set appropriate expiration times for presigned URLs