# Leo-learn

A five-month, self-driven study plan for **DSA**, **System Design**, and engineering **craft** — plus a small
command-line tool (`./lp`) that keeps track of what you studied, what you predicted, and what you still
remember three weeks later.

> **New here? Read [§1](#1-first-run-once) and [§2](#2-the-daily-loop). That is the whole system.**
> Everything else in this file is reference for when something feels off.

---

## Contents

| § | |
|---|---|
| [1](#1-first-run-once) | First run (once) |
| [2](#2-the-daily-loop) | The daily loop |
| [3](#3-the-lp-command) | The `./lp` command |
| [4](#4-repo-layout) | Repo layout |
| [5](#5-which-files-to-give-the-ai) | Which files to give the AI |
| [6](#6-the-weekly-shape) | The weekly shape |
| [7](#7-adding-a-new-topic-kafka-kubernetes-docker-) | **Adding a new topic** (Kafka, Kubernetes, Docker …) |
| [8](#8-the-one-metric-that-matters) | The one metric that matters |
| [9](#9-how-this-dies--and-the-counter) | How this dies — and the counter |
| [10](#10-the-minimum-viable-day) | The minimum viable day |

---

## 1. First run (once)

**Requirements:** `bash`, `git`, and [`jq`](https://jqlang.github.io/jq/). On macOS: `brew install jq`.

```bash
git clone https://github.com/pranesh27-leo/Leo-learn.git
cd Leo-learn
chmod +x lp learning/lp.sh learning/tutorial.sh

./lp status          # should print "None yet."
```

Then take the guided tour — it creates fake data, walks you through every command, and cleans up after itself:

```bash
bash learning/tutorial.sh
```

Finally, read [`AI-PLAYBOOK.md`](AI-PLAYBOOK.md) end to end. Twenty minutes, once. It is the difference between
an AI that teaches you and an AI that does your homework while you watch.

---

## 2. The daily loop

Four commands and about two hours. Same shape every day.

```bash
# ── 1. What do I owe past-me? (15 min, cap at 5 problems, oldest first)
./lp due
#    Re-solve each one from a BLANK file, timed. Then:
./lp mark 3 pass          # or: ./lp mark 3 fail

# ── 2. Today's topic (90 min)
./lp init dsa "2.3-sliding-window"     # creates learning/notes/dsa/23-sliding-window.md
#    Read the lesson file, build the mini-project, fill in the note.

# ── 3. Every problem you attempt: predict FIRST
./lp log dsa "2.3-sliding-window"      # asks pattern / minutes / confidence, then you solve
./lp sched dsa "2.3-sliding-window" "LC 3 Longest Substring"   # into retention

# ── 4. Close out (10 min)
./lp exam dsa "2.3-sliding-window"     # paste the output into your AI, let it grill you
git add -A && git commit -m "day 12: sliding window"
```

**That is the entire system.** Repeat for five months.

### Why the order matters

`./lp due` runs **first**, before you have any energy invested in today's shiny new topic. Retention is the
thing that decays if you let it slide, and it is the only evidence that any of this worked.

### The two-hour shape

```
0:00 – 0:15   ./lp due       Re-solve 1–2 due problems from a blank file, timed.
0:15 – 0:20   RECALL         Five rapid questions from two weeks ago. No hints. Score /5.
0:20 – 1:50   THE BLOCK      Today's work — see §6 for which day is which.
1:50 – 2:00   ./lp exam      Get examined, fill the note, commit.
```

**Start an actual timer.** The 25-minute stuck-rule only works if a clock enforces it. "I'll just try five
more minutes" is how a 40-minute problem becomes a two-hour one and the log never gets written.

---

## 3. The `./lp` command

```
./lp init  <dsa|sd> "<topic>"          Create a topic note from the template
./lp log   <dsa|sd> "<topic>"          Predict pattern/time/confidence, then solve
./lp sched <dsa|sd> "<topic>" "<prob>" Put a problem into retention (D+1/3/7/21)
./lp due                               What must I re-solve today?
./lp mark  <id> <pass|fail>            Record a retention result
./lp exam  <dsa|sd> "<topic>"          Print an AI examiner prompt with your notes
./lp status                            Where am I?
```

Full reference, including the error-tag table: [`learning/lp-help.md`](learning/lp-help.md).

### How retention works

Every problem you `sched` comes back four times:

```
solved today → D+1 → D+3 → D+7 → D+21 → ✓ retained
                 ↘     ↘     ↘
                  a failed re-solve resets the whole clock to D+1
```

No negotiation, no "but I almost had it." A reset is information, not a punishment.

### Where your data lives

| | |
|---|---|
| `learning/db.json` | Topics + the retention schedule. Plain JSON — edit it by hand if you must. |
| `learning/notes/dsa/`, `learning/notes/sd/` | One markdown note per topic. Your predictions, mistakes, and rules live here. |

Both are committed to git, so your history *is* your evidence.

---

## 4. Repo layout

```
Leo-learn/
├── lp                      ← the daily command (wrapper for learning/lp.sh)
├── README.md               ← you are here
│
├── PLAN.md                 Schedule, budget, sprint gates, calendar
├── AGENT.md                Tutor configuration — attach to every AI session
├── PATTERN-PROJECTS.md     The 47 mini-projects
├── TRACK-C-CRAFT.md        Craft themes, applied at your day job
├── AI-PLAYBOOK.md          How to use AI without it eating the learning
│
├── DSA/                    Weeks 0–6 — arrays → graphs → DP
├── System-design/          Weeks 0–6 — tradeoffs → networking → databases → design
├── Tools/                  ← empty on purpose. See §7.
├── books/                  Reference PDFs and EPUBs
│
└── learning/
    ├── lp.sh               The tool
    ├── lp-help.md          Full command reference + error tags
    ├── tutorial.sh         Guided walkthrough — run this once
    ├── db.json             Your progress data
    ├── templates/          Note templates for new topics
    └── notes/{dsa,sd}/     Your notes, one file per topic
```

Both course tracks start with a `00-START-HERE.md` and are numbered — work through them in order.

---

## 5. Which files to give the AI

The most common way to make an AI tutor worse is to hand it 90 KB of context and dilute the instruction.
**Attach fewer files, not more.** `AGENT.md` goes in every session; the rest depends on the day.

| Day | Attach |
|---|---|
| **Mon** — DSA topic | `AGENT.md` + `PLAN.md` + today's `DSA/week-N/…` file |
| **Tue** — DSA project | `AGENT.md` + `PATTERN-PROJECTS.md` |
| **Wed** — SD topic | `AGENT.md` + `PLAN.md` + today's `System-design/week-N/…` file |
| **Thu** — problems | `AGENT.md` only — you're solving; it only needs the escalation ladder |
| **Fri** — SD project | `AGENT.md` + `PATTERN-PROJECTS.md` |
| **Sat** — craft + gate | `AGENT.md` + `TRACK-C-CRAFT.md` |
| **Sprint gate** | `AGENT.md` + `PLAN.md` + your topic notes from `learning/notes/` |

Then type `START SESSION`.

`AI-PLAYBOOK.md` is for **you**, not the tutor — its contract is already copied into `AGENT.md` §2.

### Prompts worth keeping

**When you're stuck** (be honest in the second sentence — the tutor calibrates its hint from it)
> I'm stuck on `<problem>`. I've been at it for __ minutes. Here's what I tried: `<…>`. Here's what I expected
> vs what happened: `<…>`. Give me the lowest rung that unblocks me.

**After you solve something, before you move on**
> This works and passes. Don't rewrite it. Tell me the three things a staff engineer would flag in review, in
> order of importance, and what each costs in production.

**Pattern-selection drill** (Thursdays, 10 min — the highest-value AI use on this plan)
> Give me 20 problem statements from this sprint's patterns. I will name the pattern only — do not solve them.
> Then tell me which I got wrong and what surface feature fooled me.

**Edge-case killer** (after every accepted solution)
> Here's my solution. Give me the input that breaks it. Don't tell me why.

**Weekly mock** (Saturdays, 20 min)
> Cold mock interview on `<topic>`. You are slightly impatient. Minimal hints. Ask "why" after every claim I
> make. Do not tell me I'm doing well. At the end, give me the feedback you'd give a hiring committee,
> including the reservation you'd have about hiring me.

**Teach-back** (Saturdays, 10 min)
> I'm going to explain `<topic>` for five minutes. Play a smart beginner. Ask "but why?" three times, following
> the weakest part of what I say each time. Then tell me the exact sentence where my explanation first became
> hand-waving.

**Monthly meta-analysis** (attach your `learning/notes/` files)
> Here are my logged failures. Ignore my own tags. What is the single failure mode underneath these that I
> can't see because I'm inside it? Argue for it with evidence from specific entries.

`./lp exam` generates the examiner prompt for you, with your notes already pasted in.

---

## 6. The weekly shape

| Day | What you do |
|---|---|
| **Mon** | DSA lesson — read it, then code it yourself |
| **Tue** | DSA project from `PATTERN-PROJECTS.md` |
| **Wed** | System design lesson |
| **Thu** | LeetCode problems — predict, attempt, log |
| **Fri** | System design project |
| **Sat** | 4 hours: Track C (90m) · finish the project (90m) · queue sweep (60m) |
| **Sun** | **Off.** Do nothing. |

| Cadence | Do |
|---|---|
| Every session | `./lp due` → block → `./lp exam` → commit |
| Sprint day 13 | Gate: cold diagnostic, teach-back, error tally, verdict — see `PLAN.md` |
| Monthly | Meta-analysis prompt over your notes (§5) |

`PLAN.md` §4 tells you which week-folder you're in. Work through its files in number order.

---

## 7. Adding a new topic (Kafka, Kubernetes, Docker, …)

`Tools/` is **empty on purpose.** It is the home for everything outside the two core tracks — message queues,
container orchestration, build and observability tooling, whatever comes next.

**Candidates:** Kafka · Kubernetes · Docker · Redis · Terraform · Git internals · Linux/perf · gRPC · CI/CD ·
Postgres operations · observability (Prometheus, OpenTelemetry)

### How to add one

```bash
mkdir -p Tools/kafka
```

Give it the same shape the other tracks use — a `00-START-HERE.md` that says why the tool exists and what you
intend to be able to do when you're done, then numbered lesson files:

```
Tools/kafka/
├── 00-START-HERE.md
├── 1.1-what-problem-does-kafka-solve.md
├── 1.2-topics-partitions-offsets.md
└── 1.3-hands-on-produce-and-consume.md
```

Then study it exactly like any other topic — the tool does not care which track a note came from:

```bash
./lp init sd "kafka-partitions"        # use the sd track for infra topics
./lp exam sd "kafka-partitions"
```

### Two rules for this folder

1. **Hands-on, or it doesn't count.** For a tool, the artifact is a running thing — a container you built, a
   topic you produced to, a cluster you broke and fixed. Reading Kafka docs is not learning Kafka.
2. **One tool at a time, and only when a core sprint isn't mid-flight.** This folder is where a focused plan
   goes to become a bookmark pile. Finish the sprint, then add the tool.

---

## 8. The one metric that matters

You will be tempted to measure **problems solved**. That is a vanity metric — it goes up whether or not you're
learning.

**The only honest measure is your D+21 re-solve rate.** Can you still do it three weeks later, cold, from a
blank file? Below 60% means the retention queue is being neglected and nothing else should proceed.

Here is the diagnostic that catches you cheating yourself:

> **High unaided rate + low re-solve rate = you are taking hints too early.**

You're solving things "unaided" because you half-remember a shape, not because you own the pattern. It feels
like progress and it evaporates. If you see that combination at a gate, the fix isn't more problems — it's the
25-minute rule, enforced honestly.

---

## 9. How this dies — and the counter

Read this section when something feels off. Every one of these is predictable and none of them is a character
flaw.

| Failure mode | The tell | The counter |
|---|---|---|
| **Reading instead of doing** | `learning/notes/` is thin but you "covered" four topics | Nothing counts until it compiles or is written in your own words. The artifact is the study; the reading is setup. |
| **Tracking becomes a chore** | You skip the note "just today" | **Hard cap: 5 minutes/day.** If it takes longer you're over-writing. One line per field. Ugly is fine. |
| **Review queue avalanche** | 15 minutes becomes 40 | Cap at **5 re-solves/day, oldest first.** Let the rest slip. A capped queue you actually do beats a complete one you abandon. |
| **Gold-plating projects** | A "90-minute" project is on hour four | Two-hour timer. Ship it ugly, write `NOTES.md`, move on. |
| **Hint creep** | Unaided rate high, re-solve rate low (§8) | Timer on 25 minutes. Say out loud what you tried before asking. If you can't articulate it, you haven't tried. |
| **Falling behind → quitting** | Three missed days, then the guilt spiral, then nothing | §10. This is the big one. |
| **Sprint runs long** | Day 14 and you're not done | **Extend it.** The dates in `PLAN.md` are a forecast, not a contract. Never adjust reality to the plan. |
| **Studying instead of working** | Track C boxes unticked for three sprints | Track C is where confidence actually moves. If it's slipping, swap a Thursday problems session for it. |

---

## 10. The minimum viable day

**The single most important habit here.** You will have days with a production incident, a bad night's sleep,
or no motivation. On those days you do **not** skip — you do the minimum:

```bash
./lp due          # 20 minutes, retention only
git add -A && git commit -m "minimum day"
```

That's it. It preserves the queue, the streak, and — most importantly — your identity as someone who does
this. Skipping preserves none of those.

> **A missed day costs you a day. A broken streak costs you the plan.**

If you're away more than four days: don't restart the week and don't lecture yourself. Run `./lp due`, take one
easy win, resume.

---

## The three rules that carry the rest

1. **Predict before you attempt.** Every problem, every profile, every game day. The gap between prediction and
   outcome is the entire engine — that is what `./lp log` exists to capture.
2. **Type every character yourself.** For five months. The point isn't 47 finished projects; it's becoming
   someone who could have built them.
3. **When you feel behind or inadequate, open your own notes and read your prediction rows.** They exist
   precisely for that moment. It is the only argument that works, because it's yours.
