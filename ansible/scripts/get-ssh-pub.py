import boto3
import sys

client = boto3.client('ssm', region_name="us-west-2")
response = client.get_parameters(Name=sys.argv[1], withDecryption=True)
print(response["Parameter"]["Value"])