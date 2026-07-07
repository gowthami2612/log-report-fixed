# Log Report

There is an Apache-style access log at `/app/access.log`.

Create a JSON report at `/app/report.json`.

Success criteria:

1. `/app/report.json` must exist and contain a valid JSON object.
2. The JSON object must include `"total_requests"` with the total number of non-empty log lines.
3. The JSON object must include `"unique_ips"` with the number of distinct client IP addresses.
4. The JSON object must include `"top_path"` with the most frequently requested path. If there is a tie, use the path that appears first in the log.
5. The JSON object must contain exactly these keys: `total_requests`, `unique_ips`, and `top_path`.

For the provided log, the expected report is:

```json
{
  "total_requests": 6,
  "unique_ips": 3,
  "top_path": "/index.html"
}
```
