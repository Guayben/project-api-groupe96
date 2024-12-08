from flask import Flask, jsonify, request, abort, render_template
from flask_limiter import Limiter
from flask_limiter.util import get_remote_address
from azure.cosmos import CosmosClient, exceptions

from dotenv import load_dotenv
import os

from flask_cors import CORS


load_dotenv()

COSMOS_ENDPOINT = os.getenv("COSMOSDB_ENDPOINT")
COSMOS_KEY = os.getenv("COSMOSDB_READONLY_KEY")
DATABASE_NAME = os.getenv("COSMOSDB_DATABASE_NAME")
ITEMS_CONTAINER_NAME = "Items"
BASKETS_CONTAINER_NAME = "Baskets"
USERS_CONTAINER_NAME = "Users"

# Flask and Limiter configuration
app = Flask(__name__)

limiter = Limiter(
    get_remote_address,
    app=app,
    storage_uri="memory://",
)

CORS(app)

# Initialize Cosmos DB Client
client = CosmosClient(COSMOS_ENDPOINT, COSMOS_KEY)
database = client.get_database_client(DATABASE_NAME)
items_container = database.get_container_client(ITEMS_CONTAINER_NAME)
baskets_container = database.get_container_client(BASKETS_CONTAINER_NAME)
users_container = database.get_container_client(USERS_CONTAINER_NAME)

# API Key
API_KEY = "super_secret_key"

def verify_api_key():
    key = request.headers.get("x-api-key")
    if key != API_KEY:
        abort(403)  # Access denied if the key is invalid

@app.route("/")
def home():
    return jsonify({"message": "Lancelot je t'aime"})

# Items endpoint
@app.route("/items", methods=["GET"])
@limiter.limit("10 per minute")
def get_items():
    verify_api_key()
    try:
        items = list(items_container.read_all_items())
        return jsonify({"items": items})
    except exceptions.CosmosHttpResponseError as e:
        return jsonify({"error": str(e)}), 500

@app.route("/items", methods=["POST"])
def add_item():
    verify_api_key()
    data = request.json
    if not data or "id" not in data or "name" not in data:
        return jsonify({"error": "Invalid payload"}), 400

    item = {
        "id": data["id"],
        "name": data["name"],
        "partitionKey": data["id"],  # Use ID as partition key
    }

    try:
        items_container.create_item(item)
        return jsonify({"message": "Item added successfully", "item": item}), 201
    except exceptions.CosmosResourceExistsError:
        return jsonify({"error": "Item already exists"}), 409

# Baskets endpoint
@app.route("/baskets", methods=["GET"])
@limiter.limit("10 per minute")
def get_baskets():
    verify_api_key()
    try:
        baskets = list(baskets_container.read_all_items())
        return jsonify({"baskets": baskets})
    except exceptions.CosmosHttpResponseError as e:
        return jsonify({"error": str(e)}), 500

# Users endpoint
@app.route("/users", methods=["GET"])
@limiter.limit("10 per minute")
def get_users():
    verify_api_key()
    try:
        users = list(users_container.read_all_items())
        return jsonify({"users": users})
    except exceptions.CosmosHttpResponseError as e:
        return jsonify({"error": str(e)}), 500

@app.route("/ui")
def ui():
    return render_template("index.html")

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80, debug=False)
