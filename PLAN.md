# THE PLAN — 22 weeks, 14 h/week, three tracks

> **Start:** Tue 1 Sep 2026 · **End:** Sun 31 Jan 2027
> **Budget:** 2 h weekday × 5 + 4 h Saturday = **14 h/week**. Sunday is off. Not negotiable in either direction.
> **Companions:** `AGENT.md` (how the tutor behaves) · `PATTERN-PROJECTS.md` (what you build) · `TRACK-C-CRAFT.md` (the missing third track) · `AI-PLAYBOOK.md` (how to use AI without it eating the learning) · `learning/` (where you record everything)

---

## 1. Read this part first — the confidence diagnosis

You have three years of experience and you don't feel strong. Here is what is actually happening, because the fix follows from the diagnosis and not from the syllabus.

**Confidence is not a feeling produced by knowledge. It is a belief about yourself supported by evidence.** You cannot study your way into it directly. Right now you have three years of evidence and almost none of it is *legible to you* — you fixed things, shipped things, and kept no record, so your internal model of your own ability is built from the two times you got stuck in front of someone senior.

Four kinds of evidence actually move the needle. Every one of them is a thing you *record*, not a thing you *know*:

| Evidence | Where it comes from | File |
|---|---|---|
| "My prediction about myself was accurate" | Predicting time + confidence before every problem, then checking | `learning/calibration.md` |
| "I explained it out loud and it held up" | Teach-back, mock interviews, design defence | weekly gate |
| "I built it and it survived contact with reality" | 47 small projects, shipped and defended | `learning/projects/` |
| "I still had it a month later" | Cold re-solve at D+21 | `learning/review-queue.md` |

This is why `calibration.md` is the most important file in this repo and the one you will most want to skip. **Underconfidence is a calibration error exactly like overconfidence is.** My strong guess is that fifty rows in, you will find your predictions were consistently *pessimistic* — and at that point you will no longer be able to argue with yourself, because you'll be arguing with a table.

So: the plan below is 60% the syllabus you already had, and 40% a machine for generating evidence about yourself.

**One more thing.** DSA and system design are *interview* skills. They are worth learning and they are on this plan. But they are not why you feel shaky at work, and if you spend five months only on them you will finish with a better LeetCode profile and the same feeling. That is what Track C is for.

---

## 2. The three tracks

| Track | What | Where | Weekly time |
|---|---|---|---|
| **A — DSA** | Weeks 0–6, C++17, 27 projects, ~75 problems | `DSA/DSA-leetcode/` | ~6 h |
| **B — System Design** | Weeks 0–6, 20 projects, 8 cold designs | `System-design/` | ~5 h |
| **C — Engineering Craft** | Testing, debugging, concurrency, observability, SQL, writing, review, production | `TRACK-C-CRAFT.md` | ~1.5 h + **applied at your day job** |

Track C is new. It is the one that changes how you feel on a Tuesday afternoon at work, and it is nearly free in study hours because **its deliverables are done on company time, on real code**. You do not need permission to write better tests or read a service you don't understand. One theme per sprint, ten themes, one applied deliverable each.

Remaining ~1.5 h/week is the review queue and logging. That is not overhead. That is the part that makes the other 12.5 h stick.

---

## 3. The weekly rhythm

Every weekday session opens the same way. Twenty minutes of loop, one hundred minutes of work.

| Day | Block | Content |
|---|---|---|
| **Mon** | 2 h | `0:00` review queue (15m) · recall drill (5m) · **DSA new topic file** (100m) — pain → hand-trace → read → implement from scratch |
| **Tue** | 2 h | loops (20m) · **DSA pattern project** from `PATTERN-PROJECTS.md` (100m) |
| **Wed** | 2 h | loops (20m) · **SD new topic file** (100m) — failure story → sketch → read → redraw → numbers → tradeoff sentence |
| **Thu** | 2 h | loops (20m) · **DSA problems**, micro loop, 2–3 problems (100m) |
| **Fri** | 2 h | loops (20m) · **SD project or second SD topic** (100m) |
| **Sat** | 4 h | **Track C** (90m) · finish the week's project (90m) · review queue sweep + weekly log (60m) |
| **Sun** | — | **Rest.** Optional 20 min review queue if you're behind. Nothing else. |

**The Sunday rest day is load-bearing.** A plan with no rest day breaks in week three, and you will read the break as a character flaw rather than an arithmetic one. It is arithmetic. Take the day.

**Session close is mandatory** — the block in `AGENT.md` §3.2, written into `learning/progress.md`, every single session. Run `./learning/new-day.sh` and fill in the template it appends. Two minutes. If you skip the log, the plan silently becomes a reading list.

---

## 4. The calendar

Each sprint is **two calendar weeks = 28 h** and covers one DSA week-folder plus one SD week-folder plus one Track C theme. This is the correction to `AGENT.md` §1, which asked for the same content in 7–10 days.

| Sprint | Dates | Track A — DSA | Track B — System Design | Track C |
|---|---|---|---|---|
| **0** | Tue 1 – Sun 6 Sep | Bootstrap: artifacts, baseline test, contract | Self-assessment | Set up tooling |
| **1** | Mon 7 – Sun 20 Sep | W0 orientation + W1 arrays & lists | W0 orientation + W1 tradeoffs | 1. Testing |
| **2** | Mon 21 Sep – Sun 4 Oct | W2 stack, queue, hash, windows | W2 networking & traffic | 2. Debugging |
| **3** | Mon 5 – Sun 18 Oct | W3 trees, heap, binary search | W3 databases | 3. SQL & query craft |
| **4** | Mon 19 Oct – Sun 1 Nov | W4 graphs, sorting, union-find | W4 caching & asynchronism | 4. Concurrency |
| **5** | Mon 2 – Sun 15 Nov | W5 D&C, backtracking, greedy | W5 comms & security | 5. Reading unfamiliar code |
| **6** | Mon 16 – Sun 29 Nov | W6 DP 1D + 2D | W6 designs 6.1–6.4 | 6. Observability |
| **7** | Mon 30 Nov – Sun 13 Dec | W6 worked patterns + playbook | W6 designs 6.5–6.9 | 7. Performance & profiling |
| **8** | Mon 14 – Sun 20 Dec | Retention pass: D+21 backlog | Redraw 3 designs from memory | 8. Writing (design doc) |
| — | **Mon 21 Dec – Sun 3 Jan** | **HOLIDAY RESET** | nothing, or 20 min/day queue | — |
| **9** | Mon 4 – Sun 17 Jan | **MEGA PROJECT** 6.9 Log Analytics Engine | **MEGA PROJECT** 6.10 Bitly end-to-end | 9. Code review |
| **10** | Mon 18 – Sun 31 Jan | Mock interviews ×3, calibration report | Design mocks ×3, recorded talk | 10. Production & on-call |

**20 working weeks. 280 hours. The holiday reset is deliberate** — it is not slack you should feel guilty about spending, it is the thing that stops December from ending the project.

---

## 5. The gate — what "done with a sprint" means

Do not start Sprint N+1 until Sprint N passes. `AGENT.md` §3.3 defines this; here is the schedule for it.

**Sprint day 13 (second Saturday), 2 hours, closed book:**

1. **Cold diagnostic** — 4 unseen DSA problems from the sprint's patterns (60 min) + 1 "explain the internals" question + 1 design question.
2. **Teach-back** — 5 minutes explaining one topic to a beginner, out loud, no notes. Your AI tutor plays the confused student and asks "but why?" three times.
3. **Error tally** — count your tags for the sprint. One dominant failure mode, one prescription.
4. **Verdict:**

| Result | Verdict | Action |
|---|---|---|
| ≥3/4 unaided, internals explained, calibration within ±40% | **ADVANCE** | Next sprint |
| 2/4, or internals shaky | **PATCH** | Spend Sprint N+1's Monday and Tuesday on the weak pattern only, then continue |
| ≤1/4 | **REDO** | Repeat the week's material **project-first** this time, not theory-first |

A PATCH is not a failure, it is the system working. Two REDOs in a row means the pace is wrong, not that you are — cut the problem count, not the projects.

---

## 6. The budget, honestly

I costed the full contents of your folders:

```
DSA    30 topic files ×1h + 27 projects ×1.5h + 110 problems ×0.6h  ≈ 136 h
SD     35 topic files ×0.8h + 20 projects ×1.5h + 8 designs ×2h     ≈  86 h
C      10 themes ×3h                                                ≈  30 h
Loops  review queue + logging, 2.5 h/week × 20                      ≈  50 h
Gates  diagnostics, teach-backs, mocks, retros                      ≈  20 h
                                                                    ─────────
                                                            TOTAL   ≈ 322 h
                                                        AVAILABLE     280 h
                                                           OVER BY      42 h
```

**It does not fit, and I would rather tell you now than have you discover it in week nine.** Two cuts, in this order:

1. **Problems 110 → 75.** Six to eight per DSA week, chosen for pattern coverage, not volume. Saves 21 h. Grinding problem #9 in a pattern you already own is the lowest-value hour on this plan.
2. **DSA projects 27 → 20.** Drop the second project where a week has two (e.g. keep MyHashMap, skip the Ticket Simulator; keep Union-Find monitor, skip Mini-Make). Saves 10 h.

**Never cut, in any circumstance:** the review queue, the projects you kept, the session log, the gates. Those *are* the method. Everything else is content.

If 22 weeks is too long for you, the lever is not "work faster" — it is dropping a track. Tell me and I'll re-cut it. At 14 h/week, "everything, evenly" costs five months. That is the honest price.

---

## 7. What I added or changed, and why

| # | Change | Reason |
|---|---|---|
| 1 | Created `learning/` with all five artifacts + `new-day.sh` | `AGENT.md` §4 mandated them; none existed. The feedback engine was designed and never switched on. |
| 2 | `git init` + `.gitignore` | §8 step 1 required a repo. Your commit history becomes a second, unfakeable record of consistency. |
| 3 | Two-week sprints instead of "7–10 days for both tracks" | The original needs ~25 h/week. You have 14. This was the single biggest reason the plan would have failed. |
| 4 | Added **Track C** (`TRACK-C-CRAFT.md`) | Testing, debugging, concurrency, observability, SQL craft, code reading, writing, review, production. None of it was covered. This is the track that touches your actual job. |
| 5 | Added **`AI-PLAYBOOK.md`** and an AI contract in `AGENT.md` | Your last question, and a genuine hazard: AI can complete all 47 projects in an afternoon and leave you with nothing. |
| 6 | Explicit Sunday rest + a 2-week holiday reset | Plans without slack don't survive contact with a full-time job. |
| 7 | Flagged the thin week-folders | DSA W4 is 131 lines for the hardest material in the course; W5 is 121. **For Sprints 4 and 5 the `.md` files are index cards, not lessons.** Primary source is `hello-algo_1.3.0_en_cpp.pdf` (you own it) plus the project. Budget an extra hour each. |
| 8 | Cut the problem count, kept the projects | See §6. Projects generate the evidence; problem #9 in a known pattern does not. |
| 9 | Left the parking lot alone | MQTT, K8s, EMQX, Kafka, ZooKeeper stay deferred by your instruction. SD Week 4 (asynchronism) is their foundation; they are the natural block *after* 31 Jan, and given your stack you'll pick them up fast. |

---

## 8. Tracking — the whole system in one table

Five files. One you touch daily, four are trigger-driven. If tracking takes more than 5 minutes a day, it is wrong and you will abandon it.

| File | When you write to it | Trigger |
|---|---|---|
| `learning/progress.md` | **Daily**, 2 min | End of every session — run `./learning/new-day.sh` |
| `learning/calibration.md` | **Per problem**, 20 sec | One row *before* you start, one column *after* |
| `learning/mistake-log.md` | **Per failure**, 3 min | Any wrong answer, any hint taken, any timeout |
| `learning/pattern-cards.md` | **Per pattern**, 5 min | Once, when you first meet a pattern — in your own words |
| `learning/review-queue.md` | **Per problem**, 20 sec | Schedule D+1 / D+3 / D+7 / D+21. Failed re-solve resets to D+1 |

Commit at the end of every session: `git add -A && git commit -m "day N: <topic>"`. Twenty weeks from now the log itself is evidence.

---

## 9. Rules that keep this alive

| Situation | Rule |
|---|---|
| Missed a day | Nothing happens. Carry on tomorrow. Do not "catch up" by doubling. |
| Missed 3+ days | Skip to the review queue only for one session, then resume. Do not restart the week. |
| Away > 4 days | Short diagnostic to find what decayed, then one quick win. No lectures, no guilt. |
| Two review-queue skips in a row | Stop new material. Clear the queue first. This is the one hard stop. |
| A sprint runs long | Extend it. **Never adjust reality to the plan.** The dates in §4 are a forecast, not a contract. |
| "I'll skip the project and do more LeetCode" | No. The project is why you'll remember it in March. |
| Feeling behind | Open `calibration.md` and read your own rows. That is what it is for. |

---

## 10. Today — Sprint 0, exactly

Six hours across this week, no new material. Get the machine running before you drive it.

- [ ] **Tue** — Verify toolchain: `g++ --version` (C++17), git working. Read this file and `AI-PLAYBOOK.md` end to end.
- [ ] **Wed** — **Baseline test, timed, no help, 30 min:** LC 1 (Two Sum), LC 217 (Contains Duplicate), LC 20 (Valid Parentheses). Predict pattern + confidence + minutes *before each*. Write row 1–3 of `calibration.md`. This is the number everything else is measured against — a bad baseline is a *good* baseline.
- [ ] **Thu** — Self-assessment: score yourself 1–5 on every line in `TRACK-C-CRAFT.md` §Baseline. Be honest; nobody sees it. Pick your two weakest for Sprints 1–2.
- [ ] **Fri** — Write the contract from `AGENT.md` §8.5 into `learning/progress.md` in your own handwriting-equivalent, and commit it.
- [ ] **Sat** — Sprint 0 Track C: set up the tooling you'll need all plan (`gdb`/`lldb`, `perf` or `dtrace`, a profiler for Go and Node, `psql` against a scratch Postgres). Verify each one actually runs. Then start Sprint 1 Monday.

Then open a fresh chat with `AGENT.md` + `PLAN.md` + `DSA/DSA-leetcode/week-0-orientation/0.1-what-is-dsa-and-algorithms.md` attached, and say **START SESSION**.
