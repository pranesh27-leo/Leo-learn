# `tutorial.sh` — Guided Walkthrough

A 9-step interactive tour of the `lp` learning loop. It creates fake data, runs
every real command against it, and removes all of it on exit.

```bash
bash learning/tutorial.sh
```

**Requirements:** `bash`, `jq`, `awk`, GNU or BSD `date`. Verified on macOS
(bash 3.2.57, jq 1.8.2, BSD userland) and portable to Linux.

**Time:** ~5 minutes. Press Enter between steps.

---

## Contents

| Section | |
|---|---|
| [What it touches](#what-it-touches) | Files created, mutated, restored |
| [The 9 steps](#the-9-steps) | Annotated transcript of a real run |
| [Safety guards](#safety-guards) | When it refuses to run |
| [Bug audit](#bug-audit) | Defects found and fixed |
| [Verification](#verification) | How the fixes were tested |

---

## What it touches

| Path | What happens | After exit |
|---|---|---|
| `learning/notes/dsa/hash-table-two-sum.md` | Created, overwritten with demo content, one table row appended | Deleted |
| `learning/notes/sd/dns-basics.md` | Created from the SD template | Deleted |
| `learning/db.json` | Two topics added, one problem scheduled, one `mark` applied | Restored byte-for-byte from a backup |
| `learning/db.json.tutorial-backup` | Snapshot taken before step 1 | Moved back over `db.json` |

Exit code is `0` on success, `1` if a demo note name collides with a real one.
The `EXIT` trap runs cleanup even on Ctrl-C or mid-script failure.

---

## The 9 steps

### Step 1 — `lp init`

Creates a tracking note from `templates/dsa-topic.md` and registers it in `db.json`.

```
  lp init dsa "hash-table-two-sum"

Created: /Users/leo/workdir/exp/Leo-learn/learning/notes/dsa/hash-table-two-sum.md
```

The template renders with `{{TOPIC_NAME}}`, `{{WEEK}}`, `{{DATE}}` substituted.
Week is parsed from a numeric prefix in the topic name (`2.3-sliding-window` → `2`),
otherwise `0`. Prints the first 25 lines, then lists all ten sections of the note.

```
# Hash Table Two Sum

**Track:** DSA · **Week:** 0 · **Started:** 2026-09-04

## Before Starting (fill this first, 30 seconds)

- I expect the main pattern/tool to be: __________________
- I think I'll spend about ___ minutes on this
- Confidence on this topic before starting: ___ / 5
```

### Step 2 — Fill the note

No command. The script overwrites the template with a worked example — a filled
hash-table note with real prose in *What This Pattern Is*, *Trigger*, *Mini
Project*, *Where I Struggled*, *Mistakes & General Rules*, and *Complexity* —
to show what a completed note looks like.

### Step 3 — `lp log` (simulated)

Shows the interactive prompt without running it (it would block on four `read`s):

```
  --- Predict BEFORE solving ---
  Problem (e.g. LC 1 Two Sum):  LC 1 Two Sum
  Predicted pattern:             hash map
  Predicted minutes:              10
  Confidence 1-5:                 4
```

The script then appends the post-solve row directly to the note's *Problems
Solved* table, matching what `lp log` + a manual edit produce:

```
| Problem | Pred Pattern | Pred Min | Conf 1-5 | Actual Min | Correct | Unaided | Error Tag |
|---|---|---|---|---|---|---|---|
| LC 1 Two Sum | hash map | 10 | 4 | 15 | yes | yes | - |
```

Predicted 10 minutes, actual 15 — the calibration gap is the point of the step.

### Step 4 — `lp sched`

Real command. Enters the problem into spaced repetition and prints the four dates.

```
  lp sched dsa hash-table-two-sum "LC 1 Two Sum"

Scheduled: LC 1 Two Sum
Due on: 2026-09-05 → 2026-09-07 → 2026-09-11 → 2026-09-25
```

The tutorial then reads the assigned id back out of `db.json` and uses it for step 6.

### Step 5 — `lp due`

Real command against live `db.json`.

```
  lp due

Retention Due Today (2026-09-04):

Nothing due today.
```

D+1 is tomorrow, so nothing is due on the day you run the tutorial. The script
prints a mock of what tomorrow's listing looks like.

### Step 6 — `lp mark`

Real command, using the id captured in step 4.

```
  lp mark 1 pass

✓ 1 passed (d1). Next: d3
```

It also shows the failure path without executing it — `fail` resets the problem
to a fresh D+1 and rewrites all four dates. No partial credit.

### Step 7 — `lp exam` (optional, `y/n`)

Answer `y` and it runs the real command, printing the examiner prompt with the
full note inlined:

```
=== COPY EVERYTHING BELOW INTO YOUR AI ===

You are a strict examiner. I just studied a topic. Test me.

RULES:
  1. Ask 5 questions ONE AT A TIME. Wait for my answer before the next.
  2. Progression: Q1 basic → Q2 mechanism → Q3 trade-off vs alternative → Q4 edge case → Q5 real scenario
  3. After each answer: correct/incorrect, what I missed, rate 1-5
  4. After all 5: final score, weak areas, 2 specific review items
  5. If I fail 2+ questions: tell me to redo this topic

--- MY NOTES ---
[the entire note, including the LC 1 row from step 3]
--- END NOTES ---
```

### Step 8 — `lp init sd`

Real command. Same loop, different template — the SD template carries
Trade-offs, Key Numbers, and Real-World sections instead of Complexity.

```
  lp init sd "dns-basics"

Created: .../learning/notes/sd/dns-basics.md
```

### Step 9 — `lp status`

Real command, showing both demo topics and the retention counters.

```
Topics
  hash-table-two-sum [dsa] started
  dns-basics [sd] started

Retention
  Total: 1  |  In rotation: 1  |  Complete: 0
  Nothing due today
```

Then the closing summary card, cleanup, and:

```
Tutorial data cleaned up. Your real learning starts fresh.
```

---

## Safety guards

The tutorial overwrites and then deletes `hash-table-two-sum.md` and
`dns-basics.md`. If either already exists it refuses to start rather than
destroying real work:

```
Refusing to run: .../notes/dsa/hash-table-two-sum.md already exists.
The tutorial overwrites and then deletes its demo notes.
Move or rename that file first.
```

`db.json` is snapshotted before step 1 and restored on exit, so a `mark` run
during the tour cannot leave your real retention schedule advanced.

---

## Bug audit

Six defects in `tutorial.sh` and one in `lp.sh`, all found by running the script
on macOS and all fixed.

### 1. Fatal — `head -n -0` aborts the tutorial at step 3

`tutorial.sh:241` called `head -n -0` inside a block whose own comment called it
"placeholder for safety". BSD `head` rejects negative counts, and `set -e` turned
that into a hard exit.

```
$ bash learning/tutorial.sh
head: illegal line count -- -0
$ echo $?
1
```

The tutorial died at step 3 of 9 on every macOS run. **Fix:** dead code removed.

### 2. Fatal — `sed -i` is not portable

`tutorial.sh:244` used GNU syntax twice over:

```bash
sed -i '/|---|.../a\| LC 1 Two Sum | ... |' "$note"
```

BSD `sed -i` requires a backup-suffix argument, so it consumed the filename as
the suffix and then tried to parse the path as a script; BSD `sed` also rejects
`a\text` on one line.

```
sed: 2: "/private/tmp/...": undefined label 'mp/claude-501/...'
```

**Fix:** replaced with an `awk` insert, which behaves identically on both platforms.

### 3. Data loss — demo notes clobber real ones

`lp init` exits `0` with "Exists" when a note is already there, so the tutorial
continued, step 2 overwrote the file with demo content, and cleanup deleted it.

```
$ echo "MY REAL NOTES - MONTHS OF WORK" > notes/dsa/hash-table-two-sum.md
$ bash tutorial.sh    # before fix
$ ls notes/dsa/hash-table-two-sum.md
ls: no such file
```

**Fix:** pre-flight check aborts if either demo note exists.

### 4. Data corruption — hardcoded `lp mark 1 pass`

Step 6 hardcoded id `1`. Ids come from `next_id()`, so `1` is whatever the *user*
scheduled first — the tutorial silently advanced a real problem's retention stage,
and cleanup (which filtered only on demo topic names) did not undo it.

```
# before fix, with a real problem already at id 1:
{"id":"1","topic":"realtopic","problem":"REAL PROBLEM I CARE ABOUT","stage":"d3"}
                                                                     ^^^^ advanced by the tutorial
```

**Fix:** the id is read back from `db.json` after `lp sched`, and cleanup now
restores the whole `db.json` from a backup instead of surgically deleting rows.

### 5. Cosmetic — `echo` without `-e` printed raw escape codes

Ten lines interpolated `${B}` / `${Y}` into a plain `echo`, so bash 3.2 printed
the literal bytes:

```
Ready to solve LC 1 Two Sum. \033[1mPredict first\033[0m:
Each time you re-solve from a \033[1mblank file\033[0m.
```

**Fix:** `echo -e` on all ten (lines 62, 221, 248, 252, 269, 276, 306, 312, 324, 331).

### 6. Crash on non-interactive stdin

`pause()` and the step-7 `y/n` prompt used bare `read`, which returns non-zero on
EOF. Under `set -e`, `bash tutorial.sh < /dev/null` exited `1` — so the script
could not run in CI or in a smoke test.

**Fix:** `read -r _ || true`, and the `y/n` prompt defaults to `n`.

Also removed a dead no-op heredoc (`cat <<'SUMMARY'` immediately followed by
`SUMMARY`) at lines 370–371.

### 7. `lp.sh` — `mark` on an already-complete problem

`cmd_mark`'s `case "$stage"` had no branch for `done`, leaving `done_flag` empty:

```
$ ./lp mark 1 pass          # problem 1 already complete
jq: invalid JSON text passed to --argjson
✓ 1 COMPLETE — all retention stages passed
$ echo $?
0
```

jq failed, `db.json` was not written, an empty `db.json.tmp` was left behind, and
the script reported success and exited `0`. **Fix:** explicit `done` guard plus a
catch-all `*)` branch in the `case`.

### Not bugs

Behaviours checked and confirmed correct:

- Cleanup runs via `trap ... EXIT`, so Ctrl-C mid-tour still cleans up.
- `days_ahead()` probes `date -v` and falls back to `date -d` — correct on both platforms.
- `next_id()` handles an empty `.problems` array (`max // 0` → `1`).
- `lp mark <bogus-id>` correctly errors and exits `1`.
- The step-3 `awk` pattern matches the 8-column separator written in step 2.

---

## Verification

Every fix was re-run against the live script:

| Test | Result |
|---|---|
| Full interactive run, all 9 steps | exit `0`, no stderr |
| `diff` of `db.json` before vs. after | identical |
| Leftover files in `notes/dsa`, `notes/sd` | only `.gitkeep` |
| Literal `\033` sequences in output | 0 |
| `bash tutorial.sh < /dev/null` | exit `0` |
| Pre-existing real problem at id 1 | untouched, still `stage: d1` |
| Pre-existing real note at the demo path | run refused, file intact |
| `lp mark` on a completed problem | clean message, exit `0`, no stale `.tmp` |
