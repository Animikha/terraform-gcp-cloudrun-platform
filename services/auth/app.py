from flask import Flask, jsonify, request
import os
 
app = Flask(__name__)
 
@app.route("/auth")
@app.route("/auth/")
@app.route("/auth/<path:subpath>")
def api(subpath=None):
    return jsonify({
        "service": os.getenv("SERVICE_NAME", "auth"),
        "environment": os.getenv("ENV", "dev"),
        "version": os.getenv("VERSION", "v1"),
        "path": request.path
    })
 
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
