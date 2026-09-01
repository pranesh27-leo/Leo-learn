# HOW TO RUN THIS

> The operating manual. Everything else is reference; **this is the file you actually use.**
> Deliberately the shortest document here. If you only ever reread one thing, reread §6.

---

## 1. The whole thing in 30 seconds

```
1. Open a new chat. Attach AGENT.md + PLAN.md + today's topic file.
2. Type: START SESSION
3. Work the block for today (PLAN.md §3).
4. Run ./learning/new-day.sh, fill in the template.
5. git add -A && git commit -m "day N: <topic>"
```

That's it. Five months of that.

---

## 2. Which files to attach — attach fewer, not more

The single most common way to make an AI tutor worse is to give it 90 KB of context and dilute the instruction. **Never attach everything.**

| Day | Attach | Why |
|---|---|---|
| **Mon** (DSA topic) | `AGENT.md` + `PLAN.md` + the DSA topic file | The tutor needs its config, the schedule, and today's material |
| **Tue** (DSA project) | `AGENT.md` + `PATTERN-PROJECTS.md` | It needs the project spec and the review rubric |
| **Wed** (SD topic) | `AGENT.md` + `PLAN.md` + the SD topic file | Same as Monday |
| **Thu** (problems) | `AGENT.md` only | You're solving. It only needs the escalation ladder. |
| **Fri** (SD project) | `AGENT.md` + `PATTERN-PROJECTS.md` | |
| **Sat** (Track C + gate) | `AGENT.md` + `TRACK-C-CRAFT.md` | |
| **Sprint gate** | `AGENT.md` + `PLAN.md` + `learning/calibration.md` + `learning/mistake-log.md` | It needs your data to give a verdict |

`AI-PLAYBOOK.md` is for **you**, not the tutor — read it once this week. Its contract is already copied into `AGENT.md` §2, so the tutor always has it.

---

## 3. What two hours actually looks like

Non-negotiable shape. The first twenty minutes are the same every single day.

```
0:00 – 0:15   REVIEW QUEUE   Re-solve 1–2 due problems from a BLANK file, timed.
                             Cap at 5/day. Oldest first. Failed → resets to D+1.
0:15 – 0:20   RECALL DRILL   "Five rapid questions from two weeks ago. No hints. Score /5."
0:20 – 1:50   THE BLOCK      Today's work per PLAN.md §3.
1:50 – 2:00   LOG            ./learning/new-day.sh, fill it in, commit.
```

**Start the timer.** Not metaphorically. The 25-minute hard stop in the micro loop only works if a clock enforces it, and "I'll just try five more minutes" is how a 40-minute problem becomes a 2-hour one and the log never gets written.

---

## 4. The prompt library — copy these

**Session start**
> START SESSION

**When you're stuck** (be honest in the second sentence — the tutor calibrates its hint from it)
> I'm stuck on <problem>. I've been at it for __ minutes. Here's what I tried: <...>. Here's what I expected vs what happened: <...>. Give me the lowest rung that unblocks me.

**After you solve something, before you move on**
> This works and passes. Don't rewrite it. Tell me the three things a staff engineer would flag in review, in order of importance, and what each costs in production.

**Pattern-selection drill** (Thursdays, 10 min — the highest-value AI use on this plan)
> Give me 20 problem statements from this sprint's patterns. I will name the pattern only — do not solve them. Then tell me which I got wrong and what surface feature fooled me.

**Edge-case killer** (after every accepted solution)
> Here's my solution. Give me the input that breaks it. Don't tell me why.

**Weekly mock** (Saturdays, 20 min)
> Cold mock interview on <topic>. You are slightly impatient. Minimal hints. Ask "why" after every claim I make. Do not tell me I'm doing well. At the end, give me the feedback you'd give a hiring committee, including the reservation you'd have about hiring me.

**Teach-back** (Saturdays, 10 min)
> I'm going to explain <topic> for five minutes. Play a smart beginner. Ask "but why?" three times, following the weakest part of what I say each time. Then tell me the exact sentence where my explanation first became hand-waving.

**Monthly meta-analysis** (attach `learning/mistake-log.md`)
> Here are my logged failures. Ignore my own tags. What is the single failure mode underneath these that I can't see because I'm inside it? Argue for it with evidence from specific entries.

**Sprint gate** (attach `calibration.md` + `mistake-log.md`)
> Sprint __ gate. Run the cold diagnostic from AGENT.md §3.3. Then tally my error tags, give me ONE dominant failure mode and ONE prescription, and issue the verdict: ADVANCE / PATCH / REDO.

---

## 5. The one metric that matters

You will be tempted to measure **problems solved**. That is a vanity metric — it goes up whether or not you're learning.

**The only honest measure is your D+21 re-solve rate.** Can you still do it three weeks later, cold, from a blank file? Below 60% means the review queue is being neglected and nothing else should proceed.

Here's the diagnostic that catches you cheating yourself:

> **High unaided rate + low re-solve rate = you are taking hints too early.**

You're solving things "unaided" because you half-remember a shape, not because you own the pattern. It feels like progress and it evaporates. If you see that combination at a gate, the fix isn't more problems — it's the 25-minute rule, enforced honestly.

---

## 6. How this dies — and the counter

Read this section when something feels off. Every one of these is predictable and none of them is a character flaw.

| Failure mode | The tell | The counter |
|---|---|---|
| **Reading instead of doing** | `learning/dsa/` is empty but `progress.md` says you covered four topics | Nothing counts until it compiles or is written in your own words. The artifact is the study; the reading is just setup. |
| **Tracking becomes a chore** | You skip the log "just today" | **Hard cap: 5 minutes/day.** If it takes longer, you're over-writing. One line per field. Ugly is fine. |
| **Review queue avalanche** | 15 minutes becomes 40 | Cap at **5 re-solves/day, oldest first**. Let the rest slip. A capped queue you actually do beats a complete queue you abandon. |
| **Gold-plating projects** | A "90-minute" project is on hour four | Set a 2-hour timer. Ship it ugly, write `NOTES.md`, move on. `PATTERN-PROJECTS.md` rule 2 exists for this. |
| **Hint creep** | Unaided rate high, re-solve rate low (§5) | Timer on 25 minutes. Say out loud what you tried before asking. If you can't articulate it, you haven't tried. |
| **Falling behind → quitting** | Three missed days, then the guilt spiral, then nothing | §7. This is the big one. |
| **Sprint runs long** | Day 14 and you're not done | **Extend it.** The dates in `PLAN.md` §4 are a forecast, not a contract. Never adjust reality to the plan. |
| **Studying instead of working** | Track C boxes unticked for three sprints | Track C is where confidence actually moves. If it's slipping, swap a Thursday problems session for it. |

---

## 7. The minimum viable day

**The single most important habit here.** You will have days with a production incident, a bad night's sleep, or no motivation. On those days you do **not** skip — you do the minimum:

```
20 minutes. Review queue only. Log it. Commit.
```

That's it. It preserves the queue, the streak, and — most importantly — your identity as someone who does this. Skipping preserves none of those. **A missed day costs you a day; a broken streak costs you the plan.**

If you're away more than four days: don't restart the week and don't lecture yourself. Run one short diagnostic to find what decayed, take one easy win, resume.

---

## 8. Rhythm above the daily loop

| When | Do | Time |
|---|---|---|
| **Every session** | Review queue → recall drill → block → log → commit | built in |
| **Saturday** | Track C (90m) · finish the project (90m) · queue sweep + weekly log (60m) | 4 h |
| **Sunday** | **Rest.** Optional 20 min queue if behind. | 0 |
| **Sprint day 13** | Gate: cold diagnostic, teach-back, error tally, verdict | 2 h |
| **Monthly** | Meta-analysis on `mistake-log.md` (§4) | 15 min |
| **Sprint gate** | Update the running tally in `calibration.md` and the sprint tracker in `progress.md` | 10 min |

---

## 9. The three rules that carry the rest

1. **Predict before you attempt.** Every problem, every profile, every game day. The gap between prediction and outcome is the entire engine — see `PLAN.md` §1.
2. **Type every character yourself.** For five months. The point isn't 47 finished projects; it's becoming someone who could have built them.
3. **When you feel behind or inadequate, open `learning/calibration.md` and read your own rows.** That file exists precisely for that moment. It is the only argument that works, because it's yours.

---

## 10. The map

| File | What it's for | How often you open it |
|---|---|---|
| **`README.md`** | This. The operating manual. | When something feels off |
| **`PLAN.md`** | Schedule, budget, gates, calendar | Weekly |
| **`AGENT.md`** | Tutor configuration — attach to every session | Every session |
| **`PATTERN-PROJECTS.md`** | The 47 projects | Tue / Fri |
| **`TRACK-C-CRAFT.md`** | Craft themes, applied at work | Saturdays |
| **`AI-PLAYBOOK.md`** | How to use AI without it eating the learning | **Read once, this week** |
| **`learning/`** | Your five artifacts — the evidence | Daily |

**Right now:** read `AI-PLAYBOOK.md` end to end, then do the Sprint 0 checklist in `PLAN.md` §10.
