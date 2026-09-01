#!/usr/bin/env bash
# Appends today's session-close template to progress.md.
# Usage: ./learning/new-day.sh          (run it at the END of a session, then fill it in)
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG="$DIR/progress.md"
START="2026-09-01"

# Day number since the plan started
if date -j >/dev/null 2>&1; then                      # BSD date (macOS)
  s=$(date -j -f "%Y-%m-%d" "$START" "+%s")
else                                                  # GNU date
  s=$(date -d "$START" "+%s")
fi
DAY=$(( ( $(date "+%s") - s ) / 86400 + 1 ))

cat >> "$LOG" <<EOF

### $(date "+%Y-%m-%d %a") · Day $DAY
\`\`\`
Topic covered:
Recall drill:        _/5
Review queue:        _ due, _ cleared, _ failed (reset to D+1)
Problems:            _ attempted, _ solved unaided
Predicted vs actual: said _ min avg, actual _ min  -> over / under / accurate
Dominant error tag:
GREEN (owned):
YELLOW (shaky):
RED (must redo):
Track C this week:
Tomorrow's #1:
\`\`\`
EOF

echo "Appended Day $DAY to $LOG"
echo "Fill it in now — it takes two minutes and it is the whole point."
echo "Then: git add -A && git commit -m 'day $DAY'"
