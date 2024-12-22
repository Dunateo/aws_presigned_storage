import boto3
import requests
import json

session = boto3.Session(region_name='us-east-2')
lambda_client = session.client('lambda')

# Path to your JSON file
file_path = "./data_test.json"

# Read the content of the JSON file
with open(file_path, 'r') as file:
    json_data = json.load(file)

# Convert the JSON data to a string
json_string = json.dumps(json_data)

# Invoke the Lambda function
try:
    response = lambda_client.invoke(
        FunctionName='Fileuploads',
        InvocationType='RequestResponse',
        Payload=json_string
    )
    
    # Read the response
    response_payload = json.loads(response['Payload'].read().decode('utf-8'))
    print(f"Response status: {response['StatusCode']}")
    print(f"Response content: {response_payload}")

    # Extract the presigned URL from the response
    if 'body' in response_payload:
        body = json.loads(response_payload['body'])

        if 'Location' in response_payload.get('headers', {}):
            upload_url = response_payload['headers']['Location']
            
            # Upload the file using the presigned URL
            upload_response = requests.put(upload_url, data=json_string, headers={'Content-Type': 'application/json'})
            print("Request headers:", requests.utils.default_headers())
            print(f"Upload status: {upload_response.status_code}")

        else:
            print("Presigned URL not found in the response")
    else:
        print("Response body not found")

except Exception as e:
    print(f"An error occurred: {str(e)}")
