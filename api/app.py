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
CONTAINER_NAME = os.getenv("COSMOSDB_CONTAINER_NAME")

# Configuration de Flask et du Limiter
app = Flask(__name__)

limiter = Limiter(
    get_remote_address,
    app=app,
    storage_uri="memory://",
)

CORS(app)


# Initialisation Cosmos DB Client
client = CosmosClient(COSMOS_ENDPOINT, COSMOS_KEY)
database = client.get_database_client(DATABASE_NAME)
container = database.get_container_client(CONTAINER_NAME)

# Clé API
API_KEY = "super_secret_key"

def verify_api_key():
    key = request.headers.get("x-api-key")
    if key != API_KEY:
        abort(403)  # Refuser l'accès si la clé est invalide

@app.route("/")
def home():
    return jsonify({"message": "Lancelot je t'aime"})

@app.route("/items", methods=["GET"])
@limiter.limit("10 per minute")
def get_items():
    verify_api_key()
    try:
        items = list(container.read_all_items())
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
        "partitionKey": data["id"],  # Utiliser l'ID comme clé de partition
    }

    try:
        container.create_item(item)
        return jsonify({"message": "Item added successfully", "item": item}), 201
    except exceptions.CosmosResourceExistsError:
        return jsonify({"error": "Item already exists"}), 409
    
@app.route("/test-db", methods=["GET"])
def test_db():
    """Route pour tester la connexion à Cosmos DB"""
    try:
        # Lire un item depuis le conteneur
        items = list(container.read_all_items())
        return jsonify({"success": True, "message": "Connection successful", "items": items})
    except exceptions.CosmosHttpResponseError as e:
        return jsonify({"success": False, "error": str(e)}), 500
    
@app.route("/ui")
def ui():
    return render_template("index.html")


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80, debug=False)
