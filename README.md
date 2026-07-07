# log-report-fixed

Fixed Terminal-Bench 2 Harbor task for parsing an Apache-style access log into `/app/report.json`.

## Files

- `task.toml` declares the correct artifact array: `["/app/report.json"]`.
- `instruction.md` defines five explicit success criteria.
- `environment/Dockerfile` uses a digest-pinned Python base image and does not copy the reference solution.
- `.dockerignore` excludes `solution/` from the Docker build context.
- `tests/test_outputs.py` verifies the actual JSON output values.
- `tests/test.sh` runs plain pytest and writes `/logs/verifier/reward.txt` and `/logs/verifier/ctrf.json`.
- `solution/solve.sh` is the oracle solution.

## Expected fixed runs

```bash
harbor run -p log-report-fixed -a oracle
# reward: 1

harbor run -p log-report-fixed --agent nop
# reward: 0
```
