import boto3


def increment_count(ddb_table):
    try:
        # Get the current visitor count from DynamoDB
        response = ddb_table.get_item(Key={"record_id": "1"})

        # If the item exists, increment the visitor count by 1
        if "Item" in response:
            visitor_count = response["Item"]["visitor_count"]
            visitor_count = visitor_count + 1
            print(visitor_count)
        # If the item doesn't exist, set the visitor count to 1
        else:
            visitor_count = 1

        # Update the visitor count in DynamoDB
        response = ddb_table.put_item(
            Item={"record_id": "1", "visitor_count": visitor_count}
        )
        return {
            "statusCode": 200,
            "headers": {
                "Access-Control-Allow-Origin": "*",
                "Access-Control-Allow-Headers": "*",
                "Access-Control-Allow-Credentials": "*",
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
                "Access-Control-Allow-Credentials": "*",
                "Content-Type": "application/json",
            },
            "body": f"Error: {str(e)}",
        }


def lambda_handler(event, context):
    # Create a DynamoDB resource
    dynamodb = boto3.resource("dynamodb", "us-east-1")

    # Get a reference to the home_page table
    table = dynamodb.Table("home_page")

    # Increment the visitor count for the home page
    increment_count(table)

    # Return a success message
    try:
        return {
            "statusCode": 200,
            "headers": {
                "Access-Control-Allow-Origin": "*",
                "Access-Control-Allow-Headers": "*",
                "Access-Control-Allow-Credentials": "*",
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
                "Access-Control-Allow-Credentials": "*",
                "Content-Type": "application/json",
            },
            "body": f"Error: {str(e)}",
        }
