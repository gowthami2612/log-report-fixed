#!/usr/bin/env bash
set -euo pipefail

python - <<'PY'
import json
import re
from collections import Counter
from pathlib import Path

log_path = Path('/app/access.log')
report_path = Path('/app/report.json')

paths = Counter()
ips = set()
total = 0
first_seen = {}

pattern = re.compile(r'^(\S+) \S+ \S+ \[[^\]]+\] "(?:GET|POST|PUT|DELETE|HEAD|PATCH|OPTIONS) (\S+) [^"]+" \d{3} \S+')

for line in log_path.read_text().splitlines():
    line = line.strip()
    if not line:
        continue
    total += 1
    match = pattern.match(line)
    if not match:
        continue
    ip, path = match.groups()
    ips.add(ip)
    if path not in first_seen:
        first_seen[path] = total
    paths[path] += 1

top_path = min(paths.items(), key=lambda item: (-item[1], first_seen[item[0]]))[0]

report_path.write_text(json.dumps({
    'total_requests': total,
    'unique_ips': len(ips),
    'top_path': top_path,
}, indent=2) + '\n')
PY
