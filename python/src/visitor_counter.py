from flask import Flask, redirect, request
from flask_cors import CORS
import json
import os
import oracledb
import ssl


app = Flask(__name__)
CORS(app)
connection = None


# Redirect HTTP requests to HTTPS
@app.before_request
def enforce_https():
    if request.url.startswith("http://"):
        url = request.url.replace("http://", "https://", 1)
        return redirect(url, code=301)


def get_connection():
    username = os.environ.get("DB_USERNAME")
    password = os.environ.get("DB_PASSWORD")
    db_url = os.environ.get("DB_URL")
    # This line is required for me; otherwise I get a certificate verify failed error...
    # It makes a "Thick" connection, meaning it relies on Oracle (Instant) Client libraries...
    oracledb.init_oracle_client()
    connection = oracledb.connect(user=username, password=password, dsn=db_url)
    return connection


@app.route("/sequence")
def get_sequence(connection=None):
    if connection is None:
        connection = get_connection()  # Generate connection if not already present

    cursor = connection.cursor()
    cursor.execute("SELECT VISITOR_COUNT_SEQUENCE.nextval FROM dual")
    result = cursor.fetchone()
    sequence_number = result[0] if result else None
    cursor.close()
    connection.close()

    return json_response({"sequence_number": sequence_number})


def json_response(obj, status=200):
    response = app.response_class(
        response=json.dumps(obj), status=status, mimetype="application/json"
    )
    return response


if __name__ == "__main__":
    cert_file = os.environ.get("SSL_CERT_FILE")
    key_file = os.environ.get("SSL_KEY_FILE")

    # Read the certificate and key file contents
    with open(cert_file, "r") as cert_file:
        cert_data = cert_file.read()
    with open(key_file, "r") as key_file:
        key_data = key_file.read()

    # Create an SSL context with the loaded certificate and key data
    ssl_context = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
    ssl_context.load_cert_chain(certfile=cert_data, keyfile=key_data)

    # Run the app with the SSL context
    app.run(host="0.0.0.0", port=8080, ssl_context=ssl_context)
