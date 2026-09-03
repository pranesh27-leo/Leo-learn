#!/usr/bin/env bash
# lp.sh — learning path
#
# Usage:
#   lp init  <dsa|sd> "<topic>"         Create topic note from template
#   lp log   <dsa|sd> "<topic>"         Prompt for prediction, append row to note
#   lp sched <dsa|sd> "<topic>" "<prob>" Schedule problem for retention
#   lp due                                   Show problems due today
#   lp mark  <id> <pass|fail>            Record retention result
#   lp exam  <dsa|sd> "<topic>"          Print AI examiner prompt
#   lp status                              Overview
set -euo pipefail

BASE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NOTES="$BASE/notes"
TPL="$BASE/templates"
DB="$BASE/db.json"
DSA_N="$NOTES/dsa"
SD_N="$NOTES/sd"
TODAY="$(date +%Y-%m-%d)"

# days_ahead N -> YYYY-MM-DD, N days from today. Works on macOS (BSD) and Linux (GNU).
days_ahead() {
    if date -v +1d >/dev/null 2>&1; then
        date -v "+${1}d" +%Y-%m-%d          # BSD / macOS
    else
        date -d "+${1} days" +%Y-%m-%d      # GNU / Linux
    fi
}

mkdir -p "$DSA_N" "$SD_N"
[[ -f "$DB" ]] || echo '{"topics":{},"problems":[]}' > "$DB"

R='\033[0;31m'; G='\033[0;32m'; Y='\033[1;33m'; C='\033[0;36m'; B='\033[1m'; N='\033[0m'

# ---- helpers ----
sluggify() {
    echo "$1" | tr '[:upper:]' '[:lower:]' | sed 's/[[:space:]]/-/g; s/[^a-z0-9_-]//g'
}

note_path() {
    local track slug
    track=$(echo "$1" | tr '[:upper:]' '[:lower:]')
    slug=$(sluggify "$2")
    case "$track" in
        dsa) echo "$DSA_N/${slug}.md" ;;
        sd)  echo "$SD_N/${slug}.md" ;;
        *)   echo "Unknown track: $1" >&2; exit 1 ;;
    esac
}

next_id() {
    local m; m=$(jq '[.problems[].id | tonumber] | max // 0' "$DB" 2>/dev/null || echo 0)
    echo $((m + 1))
}

# ============================================================
# init
# ============================================================
cmd_init() {
    local track="${1:?track (dsa|sd)}" topic="${2:?topic name}"
    track=$(echo "$track" | tr '[:upper:]' '[:lower:]')
    local dir tpl_file
    case "$track" in
        dsa) dir="$DSA_N"; tpl_file="$TPL/dsa-topic.md" ;;
        sd)  dir="$SD_N";  tpl_file="$TPL/sd-topic.md" ;;
        *)   echo "Use dsa or sd"; exit 1 ;;
    esac

    local slug; slug=$(sluggify "$topic")
    local nf="$dir/${slug}.md"
    [[ -f "$nf" ]] && { echo -e "${Y}Exists: $nf${N}"; exit 0; }

    local pretty
    pretty=$(echo "$topic" | tr '-' ' ' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)}1')

    # Extract week from topic name (e.g. "2.3-sliding-window" → "2"), else "0"
    local week; week=$(echo "$topic" | sed -n 's/^\([0-9][0-9]*\).*/\1/p')
    [[ -z "$week" ]] && week="0"

    sed -e "s/{{TOPIC_NAME}}/$pretty/g" \
        -e "s/{{WEEK}}/$week/g" \
        -e "s/{{DATE}}/$TODAY/g" \
        "$tpl_file" > "$nf"

    jq --arg t "$track" --arg n "$topic" --arg f "$nf" \
       --arg d "$TODAY" --arg w "$week" \
       '.topics[$f] = {track:$t, name:$n, created:$d, week:$w, status:"started"}' \
       "$DB" > "$DB.tmp" && mv "$DB.tmp" "$DB"

    echo -e "${G}Created: ${B}$nf${N}"
}

# ============================================================
# log  — prompt for prediction BEFORE solving, append row
# ============================================================
cmd_log() {
    local track="${1:?track}" topic="${2:?topic}"
    local nf; nf=$(note_path "$track" "$topic")

    [[ -f "$nf" ]] || { echo -e "${R}No note. Run: lp init $track \"$topic\"${N}"; exit 1; }

    echo -e "${C}--- Predict BEFORE solving ---${N}"
    read -rp "Problem (e.g. LC 3 Longest Substring): " p_name
    read -rp "Predicted pattern:                      " p_pat
    read -rp "Predicted minutes:                      " p_min
    read -rp "Confidence 1-5:                         " p_conf

    local row; row=$(printf "| %s | %s | %s | %s | | | | |" "$p_name" "$p_pat" "$p_min" "$p_conf")

    # Find the table separator line (|---|...) under "Problems Solved" and insert after it
    local tmp="${nf}.tmp"
    awk -v row="$row" '
        /^## Problems Solved/ { in_section=1 }
        in_section && /^\|---/ { print; print row; in_section=0; next }
        { print }
    ' "$nf" > "$tmp" && mv "$tmp" "$nf"

    echo ""
    echo -e "${G}Logged. Go solve it, then edit the row with Actual/Correct/Unaided/ErrorTag.${N}"
    echo "After solving: lp sched $track \"$topic\" \"$p_name\""
}

# ============================================================
# sched  — schedule problem for retention D+1/3/7/21
# ============================================================
cmd_sched() {
    local track="${1:?track}" topic="${2:?topic}" prob="${3:?problem name}"
    local id; id=$(next_id)

    local d1 d3 d7 d21
    d1=$(days_ahead 1); d3=$(days_ahead 3); d7=$(days_ahead 7); d21=$(days_ahead 21)

    jq --arg id "$id" --arg t "$track" --arg top "$topic" --arg p "$prob" \
       --arg solved "$TODAY" \
       --arg d1 "$d1" --arg d3 "$d3" --arg d7 "$d7" --arg d21 "$d21" \
       '.problems += [{
         id:$id, track:$t, topic:$top, problem:$p,
         solved:$solved,
         d1:$d1, d3:$d3, d7:$d7, d21:$d21,
         stage:"d1", done:false
       }]' "$DB" > "$DB.tmp" && mv "$DB.tmp" "$DB"

    echo -e "${G}Scheduled: ${B}$prob${N}"
    echo "Due on: $d1 → $d3 → $d7 → $d21"
}

# ============================================================
# due  — show problems due today
# ============================================================
cmd_due() {
    echo -e "${B}Retention Due Today ($TODAY):${N}"
    echo ""

    # A problem is due if its current stage date == today and not yet done
    local rows
    rows=$(jq -r --arg t "$TODAY" '
        .problems[] | select(.done == false) |
        select(
          (.stage == "d1" and .d1 == $t) or
          (.stage == "d3" and .d3 == $t) or
          (.stage == "d7" and .d7 == $t) or
          (.stage == "d21" and .d21 == $t)
        ) |
        "  \(.id)  [\(.stage)]  \(.track)  \(.topic)  \(.problem)"
    ' "$DB" 2>/dev/null)

    if [[ -z "$rows" ]]; then
        echo -e "${G}Nothing due today.${N}"
    else
        echo "$rows"
        echo ""
        echo -e "${Y}Solve from blank file, then: lp mark <id> <pass|fail>${N}"
    fi
}

# ============================================================
# mark  — pass/fail a retention review
# ============================================================
cmd_mark() {
    local pid="${1:?id}" res="${2:?pass|fail}"
    local stage
    stage=$(jq -r --arg id "$pid" '.problems[] | select(.id == $id) | .stage' "$DB")
    [[ -z "$stage" ]] && { echo -e "${R}Problem $pid not found or already done.${N}"; exit 1; }

    if [[ "$res" == "pass" ]]; then
        local next done_flag
        case "$stage" in
            d1)  next="d3";  done_flag=false ;;
            d3)  next="d7";  done_flag=false ;;
            d7)  next="d21"; done_flag=false ;;
            d21) next="done"; done_flag=true ;;
        esac

        jq --arg id "$pid" --arg ns "$next" --argjson dn "$done_flag" '
            .problems = [.problems[] |
                if .id == $id then
                    .stage = (if $dn then "done" else $ns end) |
                    .done = $dn
                else . end
            ]' "$DB" > "$DB.tmp" && mv "$DB.tmp" "$DB"

        if $done_flag; then
            echo -e "${G}✓ $pid COMPLETE — all retention stages passed${N}"
        else
            echo -e "${G}✓ $pid passed ($stage). Next: $next${N}"
        fi

    elif [[ "$res" == "fail" ]]; then
        # Reset: new D+1 from today
        local nd1 nd3 nd7 nd21
        nd1=$(days_ahead 1); nd3=$(days_ahead 3); nd7=$(days_ahead 7); nd21=$(days_ahead 21)

        jq --arg id "$pid" --arg d1 "$nd1" --arg d3 "$nd3" --arg d7 "$nd7" --arg d21 "$nd21" '
            .problems = [.problems[] |
                if .id == $id then
                    .stage = "d1" | .done = false |
                    .d1 = $d1 | .d3 = $d3 | .d7 = $d7 | .d21 = $d21
                else . end
            ]' "$DB" > "$DB.tmp" && mv "$DB.tmp" "$DB"

        echo -e "${R}✗ $pid failed ($stage). Reset to D+1, due: $nd1${N}"
    else
        echo "Use pass or fail"
        exit 1
    fi
}

# ============================================================
# exam  — print AI examiner prompt
# ============================================================
cmd_exam() {
    local track="${1:?track}" topic="${2:?topic}"
    local nf; nf=$(note_path "$track" "$topic")
    [[ -f "$nf" ]] || { echo -e "${R}No note found.${N}"; exit 1; }

    echo -e "${C}=== COPY EVERYTHING BELOW INTO YOUR AI ===${N}"
    echo ""
    echo "You are a strict examiner. I just studied a topic. Test me."
    echo ""
    echo "RULES:"
    echo "  1. Ask 5 questions ONE AT A TIME. Wait for my answer before the next."
    echo "  2. Progression: Q1 basic → Q2 mechanism → Q3 trade-off vs alternative → Q4 edge case → Q5 real scenario"
    echo "  3. After each answer: correct/incorrect, what I missed, rate 1-5"
    echo "  4. After all 5: final score, weak areas, 2 specific review items"
    echo "  5. If I fail 2+ questions: tell me to redo this topic"
    echo ""
    echo "--- MY NOTES ---"
    cat "$nf"
    echo ""
    echo "--- END NOTES ---"
    echo ""
    echo -e "${N}"
    echo -e "${Y}After the exam, paste results into the 'AI Examiner Results' section of the note.${N}"
}

# ============================================================
# status  — overview
# ============================================================
cmd_status() {
    echo -e "${B}Topics${N}"
    local n; n=$(jq '.topics | length' "$DB")
    if [[ "$n" -eq 0 ]]; then
        echo "  None yet. Run: lp init dsa \"topic-name\""
    else
        jq -r '.topics | to_entries[] | "  \(.value.name) [\(.value.track)] \(.value.status)"' "$DB"
    fi

    echo ""
    echo -e "${B}Retention${N}"
    local total active done
    total=$(jq '.problems | length' "$DB")
    active=$(jq '[.problems[] | select(.done == false)] | length' "$DB")
    done=$(jq '[.problems[] | select(.done == true)] | length' "$DB")
    echo "  Total: $total  |  In rotation: $active  |  Complete: $done"

    local due_n
    due_n=$(jq --arg t "$TODAY" '[.problems[] | select(.done == false and (
        (.stage == "d1" and .d1 == $t) or
        (.stage == "d3" and .d3 == $t) or
        (.stage == "d7" and .d7 == $t) or
        (.stage == "d21" and .d21 == $t)
    ))] | length' "$DB")
    if [[ "$due_n" -gt 0 ]]; then
        echo -e "  ${Y}Due today: $due_n${N}"
    else
        echo -e "  ${G}Nothing due today${N}"
    fi
}

# ============================================================
# Router
# ============================================================
usage() {
    echo -e "${B}Learning Path${N}"
    echo ""
    echo "Usage: lp <command> [args]"
    echo ""
    echo "  init  <dsa|sd> \"topic\"         Create topic note"
    echo "  log   <dsa|sd> \"topic\"         Predict & log a problem"
    echo "  sched <dsa|sd> \"topic\" \"prob\"  Schedule for retention"
    echo "  due                                    Show due reviews"
    echo "  mark  <id> <pass|fail>            Record result"
    echo "  exam  <dsa|sd> \"topic\"         AI examiner prompt"
    echo "  status                                 Overview"
    echo ""
    echo "Example session:"
    echo "  lp init dsa \"sliding-window\""
    echo "  # ... read topic, build mini project, edit the note ... "
    echo "  lp log dsa sliding-window         (predicts before solving)"
    echo "  # ... solve, edit row with actuals ... "
    echo "  lp sched dsa sliding-window \"LC 3 Longest Substring\""
    echo "  lp exam dsa sliding-window        (paste output into AI)"
    echo "  # ... later, on due dates ... "
    echo "  lp due"
    echo "  lp mark 1 pass"
}

cmd="${1:-help}"
shift || true

case "$cmd" in
    init)   cmd_init "$@" ;;
    log)    cmd_log "$@" ;;
    sched)  cmd_sched "$@" ;;
    due)    cmd_due ;;
    mark)   cmd_mark "$@" ;;
    exam)   cmd_exam "$@" ;;
    status) cmd_status ;;
    *)      usage ;;
esac
