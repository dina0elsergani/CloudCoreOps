import pytest

from app import app as flask_app


@pytest.fixture
def client():
    flask_app.config.update(TESTING=True)
    return flask_app.test_client()


def test_health(client):
    r = client.get("/health")
    assert r.status_code == 200
    assert r.get_json()["status"] == "ok"


def test_index(client):
    assert client.get("/").status_code == 200


def test_info_reports_environment(monkeypatch, client):
    monkeypatch.setenv("ENVIRONMENT", "test")
    body = client.get("/api/info").get_json()
    assert body["service"] == "cloudcoreops"
    assert body["environment"] == "test"


def test_metrics_endpoint_is_prometheus_format(client):
    r = client.get("/metrics")
    assert r.status_code == 200
    assert b"# HELP" in r.data


def test_unknown_feature_is_disabled(client):
    assert client.get("/api/feature/does-not-exist").get_json()["enabled"] is False
