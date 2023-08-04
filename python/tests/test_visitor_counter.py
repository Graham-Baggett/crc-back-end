from unittest.mock import patch
from ..src import visitor_counter


@patch.object(visitor_counter, "get_connection", return_value=None)
@patch.object(visitor_counter, "oracledb")
def test_get_sequence(mock_oracledb, mock_get_connection):
    # Create a mock connection
    mock_connection = mock_oracledb.connect.return_value

    # Create a mock cursor and result
    mock_cursor = mock_connection.cursor.return_value
    mock_cursor.fetchone.return_value = (100,)

    # Call the get_sequence function with the mock connection
    response = visitor_counter.get_sequence(connection=mock_connection)

    # Check the response
    assert response.get_json() == {"sequence_number": 100}

    # Verify that the mock cursor and connection were used
    mock_oracledb.connect.assert_not_called()
    mock_cursor.execute.assert_called_once_with(
        "SELECT VISITOR_COUNT_SEQUENCE.nextval FROM dual"
    )
    mock_cursor.fetchone.assert_called_once()

    # Close the cursor and connection
    mock_cursor.close.assert_called_once()
    mock_connection.close.assert_called_once()
