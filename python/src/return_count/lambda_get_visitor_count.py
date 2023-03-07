import boto3
from typing import Any

DYNAMODB_REGION = "us-east-1"
DYNAMODB_TABLE = "home_page"
PRIMARY_KEY = "record_id"
PRIMARY_KEY_VALUE = "1"
VISITOR_COUNT_KEY = "visitor_count"


def get_count(ddb_table: Any) -> int:
    try:
        response = ddb_table.get_item(Key={PRIMARY_KEY: PRIMARY_KEY_VALUE})
        return response["Item"][VISITOR_COUNT_KEY]
    except Exception as e:
        print(f"Error fetching visitor count: {e}")
        return -1


def lambda_handler(event: dict, context: Any) -> dict:
    dynamodb = boto3.resource("dynamodb", DYNAMODB_REGION)
    table = dynamodb.Table(DYNAMODB_TABLE)

    headers = {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers": "*",
        "Content-Type": "application/json",
    }

    count = get_count(table)

    if count == -1:
        return {
            "statusCode": 500,
            "headers": headers,
            "body": {"error": "Failed to fetch visitor count"},
        }

    return {
        "statusCode": 200,
        "headers": headers,
        "body": {"visitor_count": count},
    }
