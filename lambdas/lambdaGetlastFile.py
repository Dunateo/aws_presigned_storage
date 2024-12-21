import boto3
import os
from botocore.exceptions import ClientError

def lambda_handler(event, context):
    s3_client = boto3.client('s3')
    bucket_name = os.environ['BUCKET_NAME']

    try:
        # Obtaining a List of Objects Sorted by Modification Date
        response = s3_client.list_objects_v2(Bucket=bucket_name)

        sorted_objects = sorted(response.get('Contents', []), 
                                key=lambda x: x['LastModified'], 
                                reverse=True)

        if not sorted_objects:
            return {
                'statusCode': 404,
                'body': 'No files found in the bucket'
            }

        # Retrieve the key of the most recent file.
        latest_file_key = sorted_objects[0]['Key']

        # Generate the presigned URL
        presigned_url = s3_client.generate_presigned_url('get_object',
            Params={'Bucket': bucket_name, 'Key': latest_file_key},
            ExpiresIn=3600
        )

        return {
            'statusCode': 200,
            'body': presigned_url
        }
    except ClientError as e:
        return {
            'statusCode': 500,
            'body': str(e)
        }
