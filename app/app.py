from flask import Flask, jsonify
import os
from feature_flags.simple_flags import is_feature_enabled, feature_flags

app = Flask(__name__)

@app.route("/health")
def health():
    # Health check endpoint for uptime and monitoring
    return jsonify(status="ok"), 200

@app.route("/")
def index():
    return jsonify(message="Hello from CloudCoreOps!"), 200

@app.route("/api/about")
def about():
    # NOTE: This endpoint was added to demonstrate metadata reporting for recruiters.
    return jsonify(
        author="Dina Elsergani",
        project="CloudCoreOps",
        purpose="DevOps job-ready showcase",
        version=os.getenv("APP_VERSION", "dev"),
        deployed_by=os.getenv("DEPLOYED_BY", "dina0elsergani"),
        environment=os.getenv("ENVIRONMENT", "staging"),
        fun_fact="This project was built 100% by me!"
    ), 200

@app.route("/api/features")
def features():
    """Feature flags endpoint - demonstrates feature flag functionality"""
    return jsonify(
        feature_flags=feature_flags.get_all_flags(),
        message="Feature flags are working!"
    ), 200

@app.route("/api/feature/<feature_name>")
def check_feature(feature_name):
    """Check if a specific feature is enabled"""
    is_enabled = is_feature_enabled(feature_name)
    return jsonify(
        feature=feature_name,
        enabled=is_enabled,
        message=f"Feature '{feature_name}' is {'enabled' if is_enabled else 'disabled'}"
    ), 200

# TODO: Add authentication for /api/about in production

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000) 