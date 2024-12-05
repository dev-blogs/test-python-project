from flask import Flask, jsonify, request
import mysql.connector
from mysql.connector import Error
import base64

app = Flask(__name__)


@app.route("/fetch_users", methods=["POST"])
def fetch_users():
    request_data = request.get_json()

    db_host = request_data.get('host')
    db_user = request_data.get('user')
    db_password_encoded = request_data.get('password')
    db_name = request_data.get('database')

    if not all([db_host, db_user, db_password_encoded, db_name]):
        return jsonify({'status': 'unhealthy', 'error': 'Missing database parameters'}), 400

    try:
        db_password = base64.b64decode(db_password_encoded).decode("utf-8")

        print('db_password: ' + db_password)
        connection = mysql.connector.connect(host=db_host, user=db_user, password=db_password, database=db_name)
        if connection.is_connected():
            cursor = connection.cursor(dictionary=True)
            cursor.execute('SELECT * FROM users')
            rows = cursor.fetchall()
            connection.close()

            return jsonify(rows), 200
        else:
            return jsonify({"status": "unhealthy"}), 500

    except Error as e:
        print("Error: {e}")
        return jsonify({"status": "unhealthy", "error": str(e)}), 500


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080, debug=True)