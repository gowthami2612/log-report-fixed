import json
from pathlib import Path

REPORT_PATH = Path("/app/report.json")


def load_report():
    assert REPORT_PATH.exists(), "success criterion 1 failed: /app/report.json was not created"
    try:
        return json.loads(REPORT_PATH.read_text())
    except json.JSONDecodeError as exc:
        raise AssertionError("success criterion 1 failed: /app/report.json is not valid JSON") from exc


def test_report_file_is_valid_json_object():
    """Verifies success criterion 1: create /app/report.json as a valid JSON object."""
    report = load_report()
    assert isinstance(report, dict), "success criterion 1 failed: report.json must contain a JSON object"


def test_total_requests():
    """Verifies success criterion 2: report total_requests as the number of non-empty log lines."""
    report = load_report()
    assert report.get("total_requests") == 6


def test_unique_ips():
    """Verifies success criterion 3: report unique_ips as the number of distinct client IP addresses."""
    report = load_report()
    assert report.get("unique_ips") == 3


def test_top_path():
    """Verifies success criterion 4: report top_path as the most frequently requested path with first-seen tie breaking."""
    report = load_report()
    assert report.get("top_path") == "/index.html"


def test_exact_keys():
    """Verifies success criterion 5: report contains exactly the required keys."""
    report = load_report()
    assert set(report.keys()) == {"total_requests", "unique_ips", "top_path"}
