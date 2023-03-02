import boto3


def increment_count(ddb_table):
    response = ddb_table.get_item(Key={"record_id": "1"})

    if "Item" in response:
        visitor_count = response["Item"]["visitor_count"]
        visitor_count = visitor_count + 1
        print(visitor_count)
    else:
        visitor_count = 1

    response = ddb_table.put_item(
        Item={"record_id": "1", "visitor_count": visitor_count}
    )


def lambda_handler(event, context):
    dynamodb = boto3.resource("dynamodb", "us-east-1")
    table = dynamodb.Table("home_page")
    increment_count(table)

    return {
        "statusCode": 200,
        "headers": {
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Headers": "*",
            "Access-Control-Allow-Credentials": "*",
            "Content-Type": "application/json",
            "body": "Visitor count incremented successfully!",
        },
    }
