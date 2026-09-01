# Mistake Log

> One entry per failure: wrong answer, hint taken, or 25-minute timeout. **3 minutes each.**
>
> The **"Rule I now hold"** line is the entire payload. It must generalise beyond this problem. If you write something problem-specific, you wasted the entry — rewrite it.
>
> Once a month, paste this whole file into your AI tutor and ask: *"Ignore my tags. What is the single failure mode underneath these that I can't see because I'm inside it?"* (`AI-PLAYBOOK.md` §3)

---

## Error taxonomy — exactly one primary tag per failure

| Tag | Meaning | Prescription when it exceeds 40% of your errors |
|---|---|---|
| **E1** Comprehension | Misread the problem, wrong constraints, missed a requirement | Restate the problem + hand-write 3 examples before any code. Five sessions. |
| **E2** Pattern selection | Understood it, reached for the wrong tool | 20 problem statements, name the pattern only, don't solve |
| **E3** Implementation | Right pattern, buggy code — off-by-one, loop bounds, pointers | Re-implement the core template from memory daily until automatic |
| **E4** Edge cases | Works on the example, dies on empty/single/duplicate/overflow | Mandatory pre-submit checklist: empty, size 1, all-same, negatives, max size, overflow |
| **E5** Complexity | Can't state or justify Big-O; too slow | State target complexity from the constraints *before* coding. n≤10⁵ → O(n log n) |
| **E6** Communication | Solved it silently, can't explain it | Every problem out loud from now on. Record yourself. |
| **E7** C++/STL | Language friction, not algorithmic | 15 min/day STL drills. Cheap to fix — do not confuse with E3. |

---

## Template

```markdown
### YYYY-MM-DD · LC ### · Problem Name
Predicted: <pattern>, confidence _/5, _ min
Actual:    _ min, needed rung-_ hint / unaided
ERROR TAG: E_ — <name>
Symptom:   <what actually went wrong, concretely>
Root cause: <why — the real reason, not the surface>
Fix:       <the change>
Rule I now hold: "<generalisable sentence — no problem names in it>"
Re-solve:  D+1 ☐  D+3 ☐  D+7 ☐  D+21 ☐
```

---

## Tally — recount at every sprint gate

| Sprint | E1 | E2 | E3 | E4 | E5 | E6 | E7 | Dominant | Prescription |
|---|---|---|---|---|---|---|---|---|---|
| 0 | | | | | | | | | |

---

## Entries

<!-- newest at the bottom -->
