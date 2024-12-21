import boto3
import json
import uuid
import os
from datetime import datetime

def lambda_handler(event, context):
    s3_client = boto3.client('s3')
    bucket_name = os.environ['BUCKET_NAME']
    
    # Generating a Unique File Name
    file_name = f"{datetime.now().strftime('%Y%m%d_%H%M%S')}_{uuid.uuid4().hex[:8]}.json"
    
    # Generating a Presigned URL
    presigned_url = s3_client.generate_presigned_url('put_object', 
        Params={
            'Bucket': bucket_name,
            'Key': file_name,
            'ContentType': 'application/json'
        },
        ExpiresIn=3600,
        HttpMethod="PUT"
    )

    # Building the Response
    response = {
        'statusCode': 307,
        'headers': {
            'Location': presigned_url,
            'Access-Control-Allow-Origin': '*'
        },
        'body': json.dumps({'fileName': file_name})
    }
    
    return response