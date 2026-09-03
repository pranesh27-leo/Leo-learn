# lp.sh — Learning Path

```
  init  <dsa|sd> "<topic>"         Create topic note from template
  log   <dsa|sd> "<topic>"         Prompt for prediction, append row to note
  sched <dsa|sd> "<topic>" "<prob>" Schedule problem for retention (D+1/3/7/21)
  due                                     Show problems due for re-solving today
  mark  <id> <pass|fail>            Record retention review result
  exam  <dsa|sd> "<topic>"         Print AI examiner prompt + topic summary
  status                                Overview of all topics and progress
```

---

## Your Learning Loop (one picture)

```
  lp init    →  read topic + build mini-project + fill notes
       ↓
  lp log     →  predict pattern, time, confidence BEFORE solving
       ↓
  solve it   →  edit the row with actuals, log mistakes in the note
       ↓
  lp sched   →  problem enters retention (D+1 → D+3 → D+7 → D+21)
       ↓
  lp exam    →  paste prompt into AI, it tests you 5 questions
       ↓
  lp due     →  each morning: re-solve due problems, mark pass/fail
```

---

## Retention How It Works

Every problem you schedule comes back 4 times:

```
Solved today → D+1 (tomorrow) → D+3 → D+7 → D+21 → ✓ COMPLETE
                              ↗         ↗         ↗
                        fail resets   fail resets  fail resets
                        to D+1        to D+1       to D+1
```

- **Pass** → advance to next stage
- **Fail** → reset to D+1 from today (full clock restarts)
- All 4 stages passed → problem is considered retained

Run `./lp due` each morning. It shows only what's due today.

---

## Error Tags (use in your notes)

| Tag | Meaning |
|---|---|
| E1 | Comprehension — misread the problem |
| E2 | Pattern selection — reached for wrong tool |
| E3 | Implementation — right idea, buggy code |
| E4 | Edge cases — works on example, fails on empty/negative/max |
| E5 | Complexity — can't justify Big-O |
| E6 | Communication — solved but can't explain it |
| E7 | Language/STL friction |

---

## Quick Reference

| I want to… | Command |
|---|---|
| Start studying a new topic | `./lp init dsa "topic-name"` |
| Record a problem before solving | `./lp log dsa topic-name` |
| Put a problem into retention | `./lp sched dsa topic-name "LC 1 Two Sum"` |
| See what to review today | `./lp due` |
| Record review result | `./lp mark 1 pass` or `./lp mark 1 fail` |
| Get AI to test me | `./lp exam dsa topic-name` |
| See everything at once | `./lp status` |
