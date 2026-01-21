from flask import Flask, jsonify, request 
import os

app = Flask(__name__)

@app.route("/")
def home():
    return jsonify({
        "service": os.getenv("SERVICE_NAME", "auth"),
        "environment": os.getenv("ENV", "dev"),
        "version": os.getenv("VERSION", "v1"),
        "path": request.path
    })

@app.route("/health")
def health():
    return "OK", 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
