# AI PLAYBOOK — how I would learn this in 2026

> You asked: *"if you are this person, how will you learn in this century using AI?"*
>
> Here is the honest answer, including the part that argues against my own convenience.

---

## The thing to understand before anything else

**AI can complete every artefact in this plan in one afternoon.** All 47 projects, all 75 problems, both mega projects, every design doc. It would look finished. You would have learned nothing, and — this matters more — you would know you had learned nothing, which is worse for confidence than not starting.

The value of this plan is located **entirely in the struggle it forces**. AI removes struggle. That is what it is for, and it's why it's the most dangerous tool you have ever had access to for this specific purpose.

So the first move is not "how do I use AI to learn faster". It is **drawing the line**.

---

## The contract

Print this. It is the most important part of the document.

| AI **may** | AI **may not** |
|---|---|
| Ask me questions until I find the answer | Give me the answer |
| Name the concept I'm missing | Explain the concept before I've tried to |
| Tell me *which line* is wrong | Tell me *what* is wrong with it |
| Generate 20 new problems for my weakest pattern | Solve any of them |
| Review my code **after** it works | Write code that doesn't exist yet |
| Interrogate my design | Produce my design |
| Play a confused beginner while I teach | Play the teacher while I listen |
| Show idiomatic C++/Go/TS **after** I've solved it | Show idiomatic anything before |
| Find patterns across 100 of my own logged mistakes | Tell me I'm doing great |

**The one-line test, before every prompt:** *"Am I asking this because I'm stuck, or because I'm tired?"* Tired is not stuck. Tired means stop for today.

**The 25-minute rule** (`AGENT.md` §2): no hint until you have been genuinely stuck for 25 minutes and can say what you tried. AI makes this rule harder to keep and more important to keep, because the escape hatch is now always one keystroke away and it always works.

---

## What is actually new — the seven things that were impossible in 2019

This is the real answer to your question. Not "AI explains things" — search engines did that. These seven are genuinely new, and each maps to a scarcity that used to define how fast you could get good.

### 1. Infinite calibrated practice material

**Then:** you did whatever problems existed, at whatever difficulty they happened to be.
**Now:** *"Generate 20 problem statements that look like sliding-window problems but are not. I will only name the pattern for each — do not solve them. Then tell me which ones I got wrong and what surface feature fooled me."*

This is a pattern-recognition drill targeted at your exact E2 rate, and it did not exist before. Ten minutes, twenty reps, zero solving. It's the highest-value AI use on this entire plan.

Variants worth building into your week:
- *"Take LC 3, which I just solved. Give me four variants with one constraint changed each. Don't tell me which change breaks my approach."*
- *"Here's my solution. Give me the input that breaks it."* — E4 killer.
- *"Give me a system design prompt I haven't seen, at the scale of a company with 200 engineers."*

### 2. A senior engineer who will interview you every single week

**Then:** the scarcest resource in your career was someone senior willing to interview you and be blunt. Maybe four times a year if you were lucky.
**Now:** free, unlimited, cold, at 6am.

`AGENT.md` §3.4 schedules mocks every two weeks. **Do them weekly.** The constraint that made fortnightly correct no longer exists. The prompt matters:

> *"Interview me on <topic>. You are cold and slightly impatient. Give minimal hints. Ask 'why' after every claim I make. Do not tell me I'm doing well. At the end, give me the feedback you'd give a hiring committee, including the reservation you'd have about hiring me."*

That last clause is the one that produces useful output. Without it you get encouragement, which is worthless to you.

### 3. Pattern-finding across your own mistakes

**This one is genuinely superhuman and I want you to actually do it.**

Once a month, paste your entire `mistake-log.md` and ask:

> *"Here are 40 of my logged failures. I've tagged them myself. Ignore my tags. What is the single failure mode underneath these that I cannot see because I'm inside it? Argue for it with evidence from specific entries."*

No human mentor reads 40 of your bug write-ups looking for a meta-pattern. This is the closest thing to a superpower on this list, and it's *only* available if you keep the log — which is exactly why the log is non-negotiable in `PLAN.md` §6.

### 4. The teach-back partner who is never bored

The single fastest way to find a gap is to explain something and get stuck. You needed a patient listener; nobody is that patient.

> *"I'm going to explain hash table resizing. Play a smart beginner. Ask 'but why?' three times, following the weakest part of what I say each time. Then tell me the exact sentence where my explanation first became hand-waving."*

That last request is the payload. There is always such a sentence, and you cannot hear it yourself.

### 5. Hard primary sources become approachable

You own `hello-algo_1.3.0_en_cpp.pdf`. You should also read the Dynamo paper, the Raft paper, Bigtable, Kleppmann's *DDIA*. In 2019 these were a wall.

The right prompt is **not** "summarise this". A summary transfers nothing.

> *"I've read section 4 of the Dynamo paper. Here is my understanding in my own words: <...>. Where am I wrong, and what did I skip that matters?"*
> *"Quiz me on this chapter. Five questions, hardest last. Don't accept vague answers."*

**Read first. Then use AI to attack what you extracted.** The order is everything.

### 6. Review feedback at a volume no job provides

A 3-YOE engineer has maybe 300 review comments' worth of feedback on their own code. That is the actual bottleneck on craft.

**After** your solution works:

> *"This works and passes. Don't rewrite it. Tell me the three things a staff engineer would flag in review, in order of importance, and what each one would cost me in production."*

You can do this on all 47 projects. That's 141 pieces of senior feedback on code you wrote yourself, which is more than most people get in five years.

### 7. Adversarial thinking on demand

For every design in Track B:

> *"Here is my design. You are the interviewer who wants to fail me. Find the weakest component and attack it until I either defend it or concede."*

`AGENT.md` §5.2 step 7 asks for this. Now it's unlimited and it doesn't get tired of you.

---

## What AI does **not** fix — and this is important

| Constraint | Still true in 2026 |
|---|---|
| **Retention is biological** | Spaced repetition still works the way it always did. No prompt substitutes for re-solving at D+21. The review queue is the least AI-assisted and most important part of this plan. |
| **Typing the code is part of the learning** | Motor memory and the debugging loop are physical. Reading correct code teaches you far less than writing wrong code and fixing it. |
| **Struggle is the mechanism, not a side effect** | Difficulty during learning predicts retention. AI's entire purpose is removing difficulty. Use it against its grain. |
| **Confidence needs *your* evidence** | An AI telling you you're good does nothing. Fifty rows of your own predictions coming true does everything. |
| **Judgement comes from consequences** | Nothing here replaces having shipped something, watched it break, and fixed it at 2am. That's Track C, and it happens at work. |

---

## Verification — the actual new skill of this decade

I will be confidently wrong. So will every model you use. Not often enough to be useless, and not rarely enough to be trusted.

**The rule:** every non-obvious claim that *matters* gets checked against a primary source — the standard, the docs, or an experiment you run yourself.

This is not paranoia; it's the highest-leverage habit available to you right now, because the industry is currently full of engineers who have quietly stopped verifying and haven't noticed yet. Being the person on the team who checks is a real differentiator in 2026.

Practically:
- Complexity claim → derive it yourself.
- Performance claim → benchmark it.
- "Postgres does X" → `EXPLAIN ANALYZE` it.
- Anything about a protocol → read the RFC section.
- Anything about your own codebase → read the code.

Build the reflex now, on low-stakes material, so it's automatic when the stakes are real.

---

## Working *with* agents — the 2026 job skill

Separate from learning: this is now part of craft, and it belongs in Track C.

- **Specification is the bottleneck.** An agent executes what you specified, not what you meant. Getting good at writing unambiguous specs is the same skill as writing a good design doc (Track C, Theme 8) — which is a nice confirmation that the fundamentals didn't move.
- **Review agent output harder than human output.** It is fluent, confident, plausible, and occasionally wrong in ways that look right. Your Theme 9 checklist applies double.
- **Know when not to.** Anything you need to *understand afterwards* — architecture, tricky concurrency, anything you'll be on-call for — is worth writing yourself. Anything mechanical and verifiable is not.
- **The competitive edge is judgement, not output.** Everyone has the same generation capacity now. The difference between engineers is who can tell whether the output is right, and that comes from exactly the fundamentals in Tracks A, B and C. Your plan is *more* valuable in 2026, not less.

---

## The weekly AI ritual

Fold these into `PLAN.md`'s rhythm. Total ~1 hour/week, inside existing blocks.

| When | Prompt | Purpose |
|---|---|---|
| Mon, 5 min | *"Five rapid questions from two weeks ago. No hints. Score me /5."* | Recall drill (`AGENT.md` §3.2) |
| Thu, 10 min | *"Twenty problem statements from this sprint's patterns. I name the pattern only."* | E2 pattern-selection drill |
| Sat, 20 min | *"Cold mock interview. Minimal hints. Include the reservation you'd have about hiring me."* | The weekly interview |
| Sat, 10 min | *"I'll explain <topic> for five minutes. Play a smart beginner. Ask 'but why' three times."* | Teach-back |
| Sprint end, 15 min | *"Here's my mistake-log for this sprint. Ignore my tags. What's the failure mode I can't see?"* | Meta-analysis |

---

## If I were you, in one paragraph

I would use AI as an examiner, never as an author. I would let it generate infinite practice and zero solutions. I would interview myself weekly instead of fortnightly, because that constraint is gone. I would feed it my own mistake log monthly and let it tell me the thing about myself I can't see. I would verify everything it told me that mattered, out of habit rather than distrust. And I would keep typing every single line of code myself for five months — because the whole point is not to have 47 finished projects in a folder. The point is to become the person who could have built them, and there is still exactly one way to do that.
