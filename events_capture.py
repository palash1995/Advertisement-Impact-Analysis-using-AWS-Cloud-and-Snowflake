#Lambda for Capturing the events shared by SendGrid:
import json
import datetime
import random
import boto3

client = boto3.client('kinesis')

def lambda_handler(event, context):
    ms=json.loads(event['body'])
    for i in ms:
        data = json.dumps(i)  
        client.put_record(StreamName="hellotesting", Data=data, PartitionKey="1")
        print("Data Inserted")