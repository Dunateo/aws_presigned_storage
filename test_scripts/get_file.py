import boto3
import requests

# Configure your AWS credentials
session = boto3.Session(region_name='us-east-2')
lambda_client = session.client('lambda')

def invoke_lambda():
    # Invoke a Lambda Function
    response = lambda_client.invoke(
        FunctionName='GetLastFile',
        InvocationType='RequestResponse'
    )
    
    # Extract the presigned URL from the response
    result = response['Payload'].read().decode('utf-8')
    presigned_url = eval(result)['body']
    return presigned_url

def download_and_display_file(url):
    # Download the file
    response = requests.get(url)
    
    if response.status_code == 200:
        # Display the content of the file
        print(response.text)
    else:
        print(response.text)
        print(f"Error during download: {response.status_code}")

# Main execution
if __name__ == "__main__":
    try:
        url = invoke_lambda()
        download_and_display_file(url)
    except Exception as e:
        print(f"An error occurred: {str(e)}")
