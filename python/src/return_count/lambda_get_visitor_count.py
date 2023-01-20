import json
import boto3

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('home_page')

def lambda_handler(event, context):
    response = table.get_item(Key={
       'record_id':'1'
    })
    
    return response['Item']['visitor_count']