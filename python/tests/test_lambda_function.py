from python.src.return_count import lambda_get_visitor_count
from python.src.increment_count import lambda_increment_visitor_count
import boto3
import pytest
from moto import mock_dynamodb


table_name = "home_page"


@pytest.fixture
def ddb_connection():
    with mock_dynamodb():
        ddb_conn = boto3.resource("dynamodb", "us-east-1")
        yield ddb_conn


@pytest.fixture
def ddb_table(ddb_connection):

    with mock_dynamodb():
        yield ddb_connection.create_table(
            TableName=table_name,
            KeySchema=[{"AttributeName": "record_id", "KeyType": "HASH"}],
            AttributeDefinitions=[
                {"AttributeName": "record_id", "AttributeType": "S"},
            ],
            ProvisionedThroughput={"ReadCapacityUnits": 5, "WriteCapacityUnits": 5},
        )


def test_lambda_functions(ddb_table):

    # Increment runs first because it can populate the table if empty
    lambda_increment_visitor_count.increment_count(ddb_table)
    response = ddb_table.get_item(Key={"record_id": "1"})
    visitor_count = response["Item"]["visitor_count"]
    # Increment a second time to create a comparison between the original and the new visitor_count value
    lambda_increment_visitor_count.increment_count(ddb_table)
    incremented_count = lambda_get_visitor_count.get_count(ddb_table)
    assert incremented_count == visitor_count + 1
