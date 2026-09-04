#!/usr/bin/env bash
# tutorial.sh — interactive walkthrough of the entire learning workflow
# Run: bash learning/tutorial.sh
#
# Walks through: init → fill notes → log → sched → due → mark → exam → status
# Creates and cleans up its own tutorial data. Nothing permanent.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WF="$SCRIPT_DIR/lp.sh"

R='\033[0;31m'; G='\033[0;32m'; Y='\033[1;33m'; C='\033[0;36m'; B='\033[1m'; N='\033[0m'
UL='\033[4m'

DEMO_DSA="$SCRIPT_DIR/notes/dsa/hash-table-two-sum.md"
DEMO_SD="$SCRIPT_DIR/notes/sd/dns-basics.md"
DB="$SCRIPT_DIR/db.json"
DB_BAK="$SCRIPT_DIR/db.json.tutorial-backup"

# Refuse to run if the demo topic names collide with real notes — the tutorial
# overwrites and then deletes them, which would destroy real work.
for f in "$DEMO_DSA" "$DEMO_SD"; do
    if [[ -e "$f" ]]; then
        echo "Refusing to run: $f already exists." >&2
        echo "The tutorial overwrites and then deletes its demo notes." >&2
        echo "Move or rename that file first." >&2
        exit 1
    fi
done

CLEANED=false

cleanup() {
    if $CLEANED; then return; fi
    CLEANED=true
    rm -f "$DEMO_DSA" "$DEMO_SD"
    # Restore db.json wholesale: the tutorial mutates real rows (mark), so
    # deleting only the demo rows is not enough to undo it.
    if [[ -f "$DB_BAK" ]]; then
        mv "$DB_BAK" "$DB"
    fi
}
trap cleanup EXIT

[[ -f "$DB" ]] && cp "$DB" "$DB_BAK"

sep() { echo ""; echo -e "${C}───────────────────────────────────────────────────${N}"; echo ""; }
step() { echo ""; echo -e "${B}${UL}STEP $1: $2${N}"; echo ""; }
pause() { echo ""; echo -e "${Y}>>> Press Enter to continue${N}"; read -r _ || true; }

# ============================================================
echo -e "${B}${C}
 ╔══════════════════════════════════════════════════════╗
 ║       LEARNING WORKFLOW — INTERACTIVE TUTORIAL       ║
 ╚══════════════════════════════════════════════════════╝
${N}
This is a ${B}guided walkthrough${N} of the complete learning loop.

You will experience every command:
  init   → create a topic note
  log    → predict before solving
  sched  → schedule for retention
  due    → see what's due today
  mark   → record pass/fail
  exam   → get AI to test you
  status → overview

${B}Nothing is graded.${N} Just follow along.
"
pause

# ============================================================
step 1 "Create Your First Topic Note"

echo -e "Imagine you just finished reading about ${B}Hash Tables${N} and built"
echo "the mini-project. First, create a tracking note:"
echo ""
echo -e "  ${C}lp init dsa \"hash-table-two-sum\"${N}"
echo ""

bash "$WF" init dsa "hash-table-two-sum"

echo ""
echo -e "That created: ${B}notes/dsa/hash-table-two-sum.md${N}"
echo ""
echo "Here are the first 25 lines:"
echo ""
head -25 "$SCRIPT_DIR/notes/dsa/hash-table-two-sum.md"
echo "  ... (more sections: Trigger, Problems, Struggles, Mistakes, Exam, Retention)"
echo ""
echo -e "${G}The note has these sections:${N}"
echo "  Before Starting     — prediction before you begin"
echo "  What This Pattern Is — your own words"
echo "  Trigger              — when to reach for this"
echo "  Mini Project         — what you built & why"
echo "  Problems Solved      — table with predictions + actuals"
echo "  Where I Struggled    — honest reflection"
echo "  Mistakes & Rules     — reusable knowledge"
echo "  AI Examiner Results  — from the exam step"
echo "  Retention Check      — spaced repetition log"
echo "  Final Verdict        — red/yellow/green"
echo ""
pause

# ============================================================
step 2 "Fill In Your Reflections"

echo "After reading and building, you fill in the note."
echo "Let's simulate that — replacing the template with your filled content:"
echo ""

TODAY="$(date +%Y-%m-%d)"

cat > "$SCRIPT_DIR/notes/dsa/hash-table-two-sum.md" <<EOF
# Hash Table / Two Sum

**Track:** DSA · **Week:** 0 · **Started:** $TODAY

---

## Before Starting (fill this first, 30 seconds)

- I expect the main pattern/tool to be: hash map for O(1) lookups
- I think I'll spend about 30 minutes on this
- Confidence on this topic before starting: 3 / 5

---

## What This Pattern Is (in my own words)

A hash table stores key-value pairs. You give it a key, it computes an
index (hash function), and puts the value there. Lookups are O(1) on
average because you jump directly to the right bucket - no scanning.

The trade-off: you use extra memory for the table, but gain speed.

---

## Trigger - When Do I Reach For This?

When I need to find a complement or check existence quickly.
"Find two numbers that add to target" = for each number, check if
(target - num) already exists in the map.

---

## Mini Project

**Project built:** MyHashMap with chaining, then used it to solve Two Sum
**Why this pattern was needed:** Without a hash map, nested loops O(n^2).
With it, one pass O(n). At n=100,000 the difference is huge.

**What I found during building:** Collisions matter more than I thought.
A bad hash function turns the table into a linked list.

---

## Problems Solved

> Add rows as you go. Fill Predicted BEFORE starting, Actual AFTER.

| Problem | Pred Pattern | Pred Min | Conf 1-5 | Actual Min | Correct | Unaided | Error Tag |
|---|---|---|---|---|---|---|---|

---

## Where I Struggled

I didn't initially think to store the index alongside the value in the
map. I was storing just the number, but the problem asks for indices.

---

## Mistakes & General Rules

1. **Rule:** When storing values in a hash map, always ask "do I need
   the value itself or metadata about it (index, count, position)?"

---

## What Didn't Make Sense (open questions)

- What happens when two keys hash to the exact same bucket?
  (chaining vs open addressing)

---

## Complexity

- Time: O(n) - one pass through array, each lookup O(1) average
- Space: O(n) - hash map stores up to n entries
- Why: We trade space (the map) for time (no nested loop)

---

## AI Examiner Results

> Paste the exam feedback here after running lp exam

**Date:**
**Score:**
**Weak areas flagged:**
**Action items:**

---

## Retention Check

> Fill when the problem comes up in lp due

| Problem | D+1 | D+3 | D+7 | D+21 | Final |
|---|---|---|---|---|---|
| | | | | | |

---

## Final Verdict

- [ ] RED - must redo this pattern
- [ ] YELLOW - shaky, review soon
- [ ] GREEN - owned
EOF

echo -e "${G}✓ Simulated: note is filled with your reflections${N}"
echo ""
echo -e "The key: your note is a ${B}living document${N}."
echo "Starts blank, you fill it as you learn, come back to it later."
echo ""
pause

# ============================================================
step 3 "Log a Problem (Predict BEFORE Solving)"

echo -e "Ready to solve LC 1 Two Sum. ${B}Predict first${N}:"
echo ""
echo -e "${Y}This is the most important step. Predicting before solving${N}"
echo -e "${Y}builds calibration - the evidence that fixes low confidence.${N}"
echo ""
echo -e "Command: ${C}lp log dsa hash-table-two-sum${N}"
echo ""
echo -e "${G}A real session looks like this:${N}"
echo ""
echo -e "  ${C}--- Predict BEFORE solving ---${N}"
echo -e "  Problem (e.g. LC 1 Two Sum):  ${B}LC 1 Two Sum${N}"
echo -e "  Predicted pattern:             ${B}hash map${N}"
echo -e "  Predicted minutes:              ${B}10${N}"
echo -e "  Confidence 1-5:                 ${B}4${N}"
echo ""
echo -e "  ${G}Logged. Go solve it...${N}"
echo ""

# Simulate by appending a row to the Problems table.
# awk, not `sed -i` — BSD sed needs a backup-suffix argument and rejects `a\text`.
awk '
    /^\|---\|---\|---\|---\|---\|---\|---\|---\|/ {
        print
        print "| LC 1 Two Sum | hash map | 10 | 4 | 15 | yes | yes | - |"
        next
    }
    { print }
' "$DEMO_DSA" > "$DEMO_DSA.tmp" && mv "$DEMO_DSA.tmp" "$DEMO_DSA"

echo "After solving (took 15 min, solved correctly, no help):"
echo -e "You ${B}edit the row yourself${N} with actuals:"
echo ""
echo "  | LC 1 Two Sum | hash map | 10 | 4 | 15 | yes | yes | - |"
echo ""
echo -e "Predicted 10 min, actual 15. You now have ${Y}evidence${N} that you"
echo "slightly underestimate time. That data accumulates and becomes useful."
echo ""
pause

# ============================================================
step 4 "Schedule for Retention (D+1 / D+3 / D+7 / D+21)"

echo "So you don't forget, the problem enters spaced repetition:"
echo ""
echo -e "  ${C}lp sched dsa hash-table-two-sum \"LC 1 Two Sum\"${N}"
echo ""

bash "$WF" sched dsa "hash-table-two-sum" "LC 1 Two Sum"

# The id lp assigned to the demo row — never assume it is 1.
DEMO_ID=$(jq -r '[.problems[] | select(.topic == "hash-table-two-sum")] | last | .id' "$DB")

echo ""
echo "The problem will come back on those 4 dates."
echo -e "Each time you re-solve from a ${B}blank file${N}."
echo ""
pause

# ============================================================
step 5 "Each Morning: Check What's Due"

echo -e "Each session starts with ${B}lp due${N}:"
echo ""
echo -e "  ${C}lp due${N}"
echo ""

bash "$WF" due

echo ""
echo -e "${Y}Nothing due today${N} (D+1 is tomorrow). Here's what tomorrow looks like:"
echo ""
echo -e "  ${B}Retention Due Today (tomorrow):${N}"
echo "    $DEMO_ID  [d1]  dsa  hash-table-two-sum  LC 1 Two Sum"
echo ""
echo -e "  ${Y}Solve from blank file, then: lp mark <id> <pass|fail>${N}"
echo ""
pause

# ============================================================
step 6 "Mark a Retention Result"

echo "You re-solve LC 1 from a blank file. Got it right. Record it:"
echo ""
echo -e "  ${C}lp mark $DEMO_ID pass${N}"
echo ""

bash "$WF" mark "$DEMO_ID" pass

echo ""
echo "Advanced from D+1 → D+3. Comes back in 2 days."
echo ""
echo -e "If you had ${B}failed${N}:"
echo ""
echo -e "  ${R}lp mark $DEMO_ID fail${N}"
echo ""
echo -e "  ${R}✗ $DEMO_ID failed (d1). Reset to D+1, due: <tomorrow>${N}"
echo ""
echo -e "A failure ${B}resets the entire clock${N}. No partial credit."
echo ""
pause

# ============================================================
step 7 "The AI Examiner"

echo "After finishing the topic, get tested:"
echo ""
echo -e "  ${C}lp exam dsa hash-table-two-sum${N}"
echo ""
echo "This prints a prompt you paste into your AI. The AI:"
echo -e "  1. Asks 5 questions ${B}one at a time${N}"
echo "  2. Progresses: basic → mechanism → trade-off → edge case → scenario"
echo "  3. Rates each answer 1-5"
echo "  4. Gives final score + weak areas + review items"
echo "  5. Says 'redo this topic' if you fail 2+ questions"
echo ""
echo "After the exam, paste results into the note's"
echo -e "${B}AI Examiner Results${N} section."
echo ""
echo -e "${Y}See the exam prompt? (y/n): ${N}"
read -r show_exam || show_exam="n"
if [[ "$show_exam" == "y" || "$show_exam" == "Y" ]]; then
    echo ""
    bash "$WF" exam dsa "hash-table-two-sum"
    pause
fi

# ============================================================
step 8 "System Design - Same Pattern"

echo "System Design uses the exact same loop, different template."
echo "SD template has: Trade-offs, Key Numbers, Real-World connections."
echo ""
echo -e "  ${C}lp init sd \"dns-basics\"${N}"
echo ""

bash "$WF" init sd "dns-basics"

echo ""
echo -e "Created: ${B}notes/sd/dns-basics.md${N}"
echo ""
echo "Same loop for SD: read → build → log → sched → due → exam"
echo ""
pause

# ============================================================
step 9 "Check Everything at Once"

echo -e "  ${C}lp status${N}"
echo ""
bash "$WF" status

sep

# ============================================================
# Write the final message to avoid shell interpretation of angle brackets
cat <<'ENDMSG'
 ╔══════════════════════════════════════════════════════╗
 ║          TUTORIAL COMPLETE - YOU KNOW THE LOOP       ║
 ╚══════════════════════════════════════════════════════╝

Your workflow from today on:

  MORNING (first 15 min of session):
    lp due                                ← re-solve due problems
    lp mark <id> pass|fail                ← record results

  MAIN WORK (100 min):
    lp init <track> "<topic>"             ← create note for new topic
    # read the topic file
    # build the mini-project
    # fill in the note sections
    lp log <track> <topic>                ← predict before each problem
    # solve, edit the row with actuals
    lp sched <track> <topic> "<problem>"  ← enter retention

  AFTER TOPIC:
    lp exam <track> <topic>               ← paste into AI, get tested
    # paste results into the note

  ANYTIME:
    lp status                             ← see where you are

  The note file is your single source of truth for each topic.
  db.json is the machine-readable tracker for retention.
ENDMSG

echo ""

# Clean up tutorial artifacts
cleanup

echo -e "${C}Tutorial data cleaned up. Your real learning starts fresh.${N}"
echo ""
echo -e "When ready: ${B}lp init dsa \"your-first-real-topic\"${N}"
