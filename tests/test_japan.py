import time

import psycopg2
import pytest

# Define the expected schema for the japan database
EXPECTED_SCHEMA = {
    "japan": {
        "columns": ["id", "data", "created_to"],
    }
}


@pytest.fixture(scope="module")
def db_connection():
    """Fixture to connect to the test database with retries."""
    for _ in range(10):  # Retry up to 10 times
        try:
            conn = psycopg2.connect(
                dbname="test_db",
                user="test_user",
                password="test_pass",
                host="postgres",
                port=5432,
            )
            yield conn
            conn.close()
            return
        except psycopg2.OperationalError:
            print("Waiting for the database to be ready...")
            time.sleep(3)
    pytest.fail("Could not connect to the database after multiple retries.")


def test_japan_schema(db_connection):
    """Test to validate the schema of the japan database."""
    cursor = db_connection.cursor()

    # Check if the table exists
    cursor.execute(
        """
        SELECT table_name
        FROM information_schema.tables
        WHERE table_schema = 'public' AND table_name = 'japan';
    """
    )
    tables = cursor.fetchall()
    assert ("japan",) in tables, "Table 'japan' is missing from the schema."

    # Check the columns of the table
    cursor.execute(
        """
        SELECT column_name
        FROM information_schema.columns
        WHERE table_name = 'japan';
    """
    )
    columns = {row[0] for row in cursor.fetchall()}
    expected_columns = set(EXPECTED_SCHEMA["japan"]["columns"])
    assert columns == expected_columns, f"Schema mismatch for 'japan': {columns} != {expected_columns}"
