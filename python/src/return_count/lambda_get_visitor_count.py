import boto3


def get_count(ddb_table):
    response = ddb_table.get_item(Key={"record_id": "1"})
    return response["Item"]["visitor_count"]


def lambda_handler(event, context):
    dynamodb = boto3.resource("dynamodb", "us-east-1")
    table = dynamodb.Table("home_page")

    return get_count(table)
