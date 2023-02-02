from python.src.return_count import lambda_get_visitor_count
from python.src.increment_count import lambda_increment_visitor_count
import boto3
from moto import mock_dynamodb


@mock_dynamodb
def create_table(dynamodb_connection, table_name):

    return dynamodb_connection.create_table(
        TableName=table_name,
        KeySchema=[{"AttributeName": "record_id", "KeyType": "HASH"}],
        AttributeDefinitions=[
            {"AttributeName": "record_id", "AttributeType": "S"},
        ],
        ProvisionedThroughput={"ReadCapacityUnits": 5, "WriteCapacityUnits": 5},
    )


@mock_dynamodb
def get_dynamodb_connection():
    """DynamoDB mock client."""
    conn = boto3.resource("dynamodb", region_name="us-east-1")

    return conn


@mock_dynamodb
def test_lambda_handler():

    table_name = "home_page"
    ddb_conn = get_dynamodb_connection()
    table = create_table(ddb_conn, table_name)
    data = {"record_id": "1", "visitor_count": 20}
    table.put_item(TableName=table_name, Item=data)
    response = table.get_item(Key={"record_id": "1"})
    visitor_count = response["Item"]["visitor_count"]
    actual_output = lambda_get_visitor_count.get_count(table)
    assert actual_output == visitor_count
    lambda_increment_visitor_count.increment_count(table)
    incremented_count = lambda_get_visitor_count.get_count(table)
    assert incremented_count == visitor_count + 1
