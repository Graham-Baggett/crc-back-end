import boto3

DYNAMODB_REGION = "us-east-1"
DYNAMODB_TABLE = "home_page"
PRIMARY_KEY = "record_id"
PRIMARY_KEY_VALUE = "1"
VISITOR_COUNT_KEY = "visitor_count"


def increment_count(ddb_table):
    try:
        # Get the current visitor count from DynamoDB
        response = ddb_table.get_item(Key={PRIMARY_KEY: PRIMARY_KEY_VALUE})

        # If the item exists, increment the visitor count by 1
        if "Item" in response:
            visitor_count = response["Item"][VISITOR_COUNT_KEY]
            visitor_count = visitor_count + 1
            print(visitor_count)
        # If the item doesn't exist, set the visitor count to 1
        else:
            visitor_count = 1

        # Update the visitor count in DynamoDB
        response = ddb_table.put_item(
            Item={PRIMARY_KEY: PRIMARY_KEY_VALUE, VISITOR_COUNT_KEY: visitor_count}
        )
        return {
            "statusCode": 200,
            "headers": {
                "Access-Control-Allow-Origin": "*",
                "Access-Control-Allow-Headers": "*",
                "Content-Type": "application/json",
            },
            "body": f"Visitor count incremented successfully!",
        }

    except Exception as e:
        print(f"An error occurred: {e}")
        return {
            "statusCode": 500,
            "headers": {
                "Access-Control-Allow-Origin": "*",
                "Access-Control-Allow-Headers": "*",
                "Content-Type": "application/json",
            },
            "body": f"Error: {str(e)}",
        }


def lambda_handler(event, context):
    # Create a DynamoDB resource
    dynamodb = boto3.resource("dynamodb", DYNAMODB_REGION)

    # Get a reference to the home_page table
    table = dynamodb.Table(DYNAMODB_TABLE)

    # Increment the visitor count for the home page
    return increment_count(table)
