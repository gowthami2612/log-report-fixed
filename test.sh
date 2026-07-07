#!/usr/bin/env bash
set +e

mkdir -p /logs/verifier

pytest -q /tests/test_outputs.py
status=$?

if [ "$status" -eq 0 ]; then
  reward="1"
  passed=5
  failed=0
  outcome="passed"
else
  reward="0"
  passed=0
  failed=1
  outcome="failed"
fi

echo "$reward" > /logs/verifier/reward.txt

cat > /logs/verifier/ctrf.json <<EOF_JSON
{
  "results": {
    "tool": {
      "name": "pytest"
    },
    "summary": {
      "tests": 5,
      "passed": $passed,
      "failed": $failed,
      "pending": 0,
      "skipped": 0,
      "other": 0,
      "start": 0,
      "stop": 0
    },
    "tests": [
      {
        "name": "log report verifier",
        "status": "$outcome"
      }
    ]
  }
}
EOF_JSON

exit 0
