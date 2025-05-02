import app as flask_app

def test_health():
    client = flask_app.app.test_client()
    response = client.get("/health")
    assert response.status_code == 200
    assert response.get_json()["status"] == "ok" 