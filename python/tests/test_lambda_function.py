# from python.src.return_count import lambda_get_visitor_count
# from python.src.increment_count import lambda_increment_visitor_count
# import boto3
# import pytest
# from moto import mock_dynamodb


# DYNAMODB_REGION = "us-east-1"
# DYNAMODB_TABLE = "home_page"
# PRIMARY_KEY = "record_id"
# PRIMARY_KEY_VALUE = "1"
# VISITOR_COUNT_KEY = "visitor_count"


# @pytest.fixture
# def ddb_connection():
#     with mock_dynamodb():
#         yield boto3.resource("dynamodb", DYNAMODB_REGION)


# @pytest.fixture
# def ddb_table(ddb_connection):
#     return ddb_connection.create_table(
#         TableName=DYNAMODB_TABLE,
#         KeySchema=[{"AttributeName": PRIMARY_KEY, "KeyType": "HASH"}],
#         AttributeDefinitions=[
#             {"AttributeName": PRIMARY_KEY, "AttributeType": "S"},
#         ],
#         ProvisionedThroughput={"ReadCapacityUnits": 5, "WriteCapacityUnits": 5},
#     )


# def test_lambda_functions(ddb_table):

#     # Increment runs first because it can populate the table if empty
#     lambda_increment_visitor_count.increment_count(ddb_table)
#     response = ddb_table.get_item(Key={PRIMARY_KEY: PRIMARY_KEY_VALUE})
#     visitor_count = response["Item"][VISITOR_COUNT_KEY]
#     # Increment a second time to create a comparison between the original and the new visitor_count value
#     lambda_increment_visitor_count.increment_count(ddb_table)
#     incremented_count = lambda_get_visitor_count.get_count(ddb_table)
#     assert (
#         incremented_count == visitor_count + 1
#     ), "increment_count did not increment the visitor count correctly."
