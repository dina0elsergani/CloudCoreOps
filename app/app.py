import os

from flask import Flask, jsonify
from prometheus_flask_exporter import PrometheusMetrics

from feature_flags.simple_flags import feature_flags, is_feature_enabled

app = Flask(__name__)

# Exposes /metrics in Prometheus text format; the ServiceMonitor scrapes it.
metrics = PrometheusMetrics(app)
metrics.info("cloudcoreops_app_info", "Application metadata",
             version=os.getenv("APP_VERSION", "dev"))


@app.route("/health")
def health():
    return jsonify(status="ok"), 200


@app.route("/")
def index():
    return jsonify(message="Hello from CloudCoreOps!"), 200


@app.route("/api/info")
def info():
    return jsonify(
        service="cloudcoreops",
        version=os.getenv("APP_VERSION", "dev"),
        environment=os.getenv("ENVIRONMENT", "unset"),
    ), 200


@app.route("/api/features")
def features():
    return jsonify(feature_flags=feature_flags.get_all_flags()), 200


@app.route("/api/feature/<feature_name>")
def check_feature(feature_name):
    return jsonify(feature=feature_name, enabled=is_feature_enabled(feature_name)), 200


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
