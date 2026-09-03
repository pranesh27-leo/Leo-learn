# TRACK C — Engineering Craft

> The missing track. DSA and system design are interview skills. **This is the track that changes how you feel on a Tuesday afternoon at work.**
>
> Ten themes, one per sprint, 90 minutes each Saturday. Every theme has a **deliverable done on company time, on real code** — which is why a whole third track costs you almost nothing in study hours. You do not need permission to write better tests or to read a service you don't understand.

**Your stack, so the tooling below is yours and not generic:** C, C++, Go, TypeScript/Node, Python, Perl, Bash, PostgreSQL, SQLite, NoSQL.

---

## Baseline — score yourself 1–5, today

Do this in Sprint 0. 1 = "I've heard of it", 3 = "I can do it with docs open", 5 = "I'd teach it". Nobody sees this. The two lowest scores go first.

```
[ ] I can write a test for code I'm afraid to change, without rewriting the code first
[ ] I can debug a bug I cannot reproduce locally
[ ] I reach for a debugger before print statements
[ ] I can read EXPLAIN ANALYZE and say why a query is slow
[ ] I can explain what a data race is and prove one exists with a tool
[ ] I can answer "why was p99 slow at 3pm yesterday" from our dashboards
[ ] I profile before optimising, and have the before/after numbers
[ ] I can be dropped into a 200k-line codebase and find the request path in an hour
[ ] I have written a design doc that someone else reviewed and used
[ ] I give code review comments that change the design, not just the naming
[ ] I have been on-call and did not feel sick about it
[ ] I can say "I don't know, here's how I'd find out" without it costing me anything
```

That last line is the real target of this whole plan. Confidence is not knowing everything; it is having a reliable method for not knowing.

---

## Theme 1 · Testing — Sprint 1

**The gap:** most 3-YOE engineers write tests that pass and prove nothing. Coverage percentage is a comfort metric, not a quality metric.

| Learn | Do |
|---|---|
| Unit vs integration vs end-to-end — and which one actually catches your bugs | Table-driven tests in Go (`t.Run` subtests); `pytest` fixtures/parametrize; `vitest` in TS |
| Property-based testing — the biggest single upgrade available to you | `hypothesis` (Python) or `fast-check` (TS). Test **invariants**, not examples |
| Test doubles: fake vs stub vs mock, and why over-mocking makes tests useless | Replace one mock-heavy test with a fake and see it get shorter |
| Why coverage lies | Write a 100%-covered function with an obvious bug. Keep it as a reminder |

**Deliverable:** pick the module at work you are most *afraid to change*. Write tests until you would refactor it on a Friday afternoon. That fear is a measurable thing and you just removed it.

**Ties to:** DSA edge-case tag E4. Your pre-submit checklist (empty / size 1 / all-same / negatives / max / overflow) *is* a test suite.

**Fallback (if your job doesn't fit):** Pick a small OSS library (e.g. `stb_image.h`, Go's `encoding/json`) and write property-based tests for its public API using `fast-check` (TS) or `hypothesis` (Python). Find at least one input that triggers an edge case the maintainers missed — file an issue with your test as a reproducer.

---

## Theme 2 · Debugging under pressure — Sprint 2

**The gap:** printf debugging works until the bug is in production, intermittent, or in someone else's code. Then you need a method.

| Learn | Do |
|---|---|
| Hypothesis-driven debugging: state the hypothesis, design the observation that would *falsify* it | Write the hypothesis down before each attempt. This alone halves debug time |
| `gdb`/`lldb` for C/C++ — breakpoints, watchpoints, `bt`, core dumps | Debug a segfault from a core dump, not from a rerun |
| `dlv` for Go · `node --inspect` + Chrome DevTools · `pdb`/`py-spy` for Python | One real bug in each |
| `git bisect` — binary search over history | Automate it: `git bisect run ./test.sh` |
| Debugging what you can't reproduce: logs, core dumps, `strace`/`dtruss`, tcpdump | Trace a syscall path on something you wrote |

**Deliverable:** write up your last three production bugs. For each: symptom → hypothesis chain → root cause → **the general rule you now hold**. Same format as the "Mistakes & General Rules" section of a topic note. You will find they share a root cause, and that is worth more than any of the three fixes.

**Ties to:** DSA 3.4 binary search. `git bisect` is binary search over commits; the debugger's "is the bug before or after this line" is binary search over execution.

---

## Theme 3 · SQL and query craft — Sprint 3

**The gap:** SD Week 3 teaches sharding and replication — the theory of scaling databases. It teaches nothing about making *one* query fast, which is what you actually do every week with Postgres and SQLite.

| Learn | Do |
|---|---|
| `EXPLAIN ANALYZE` — read it properly: seq scan vs index scan, estimated vs actual rows, where time goes | Take your five slowest queries and read each plan |
| Index design: B-tree, composite key order, covering indexes, partial indexes, why an index can be *ignored* | Add an index that doesn't get used. Work out why |
| N+1 queries — the single most common performance bug in the industry | Find one in your codebase. There is one |
| Transaction isolation: read committed vs repeatable read vs serializable; what a phantom read actually is | Reproduce a lost update in two `psql` sessions |
| Deadlocks, lock ordering, `pg_stat_activity`, `pg_locks` | Cause a deadlock on purpose, then read the log Postgres gives you |

**Deliverable:** find the worst query in your production system. Fix it. Record before/after with `EXPLAIN ANALYZE` output and the wall-clock number. That artefact is a promotion conversation.

**Ties to:** DSA 3.2 BST (a B-tree index *is* the balanced-tree lesson, on disk) and SD 3.1.

---

## Theme 4 · Concurrency — Sprint 4

**The gap:** you write Go and C++ and Node. Three completely different concurrency models, and the bugs are invisible until they aren't.

| Learn | Do |
|---|---|
| The three models: goroutines+channels (Go), threads+mutex (C/C++), single-threaded event loop (Node) | Write the same producer/consumer in all three. The differences are the lesson |
| What a data race actually is — memory model, not "two things at once" | `go run -race`, and `clang -fsanitize=thread` on the C++ version |
| Deadlock: the four conditions, and lock ordering as the practical cure | Write a deadlock deliberately. Then fix it by ordering locks |
| `sync.WaitGroup`, `errgroup`, `context` cancellation · `std::atomic`, `std::mutex`, RAII locking | Cancel a tree of in-flight work cleanly. Harder than it sounds |
| Why "just add a mutex" is often the wrong answer — contention, false sharing | Benchmark a mutex-heavy path vs a channel/sharded path |

**Deliverable:** write a concurrent bug on purpose in Go, ship it to a branch, then *find it with the race detector rather than by reading*. Learning to trust the tool over your eyes is the whole point.

**Ties to:** SD 4.3 asynchronism, SD 1.4 consistency. A data race is a consistency violation at the scale of one machine.

---

## Theme 5 · Reading unfamiliar code — Sprint 5

**The gap:** this is the highest-frequency senior activity and nobody is ever taught a method. You are handed 200k lines and expected to feel calm.

**The method — use it every time, in this order:**

1. **Build and run it first.** Nothing else works until you can execute it.
2. **Find the entrypoint.** `main`, the router table, the server bootstrap. One file.
3. **Follow exactly one request end to end.** Ignore all other features. Ignore them aggressively.
4. **Find the data model.** Schema or core structs. This tells you what the system *believes exists*.
5. **Draw it.** Boxes and arrows, by hand, one page. If you can't draw it you haven't read it.
6. **Change one small thing** and watch it take effect. That converts reading into knowing.
7. **Write the one-page note** you wish had existed when you started.

**Deliverable:** pick a real OSS codebase in a language you use and produce that one-page architecture note. Suggestions, ranked by ratio of insight to pain: **SQLite** (`btree.c` — and you've just done trees and B-trees), **Go's `net/http`**, **Redis** (`dict.c` is the hash-map lesson in production form).

**Ties to:** DSA 2.2 hash internals, 3.2 BST. You will read the production version of a structure you built yourself six weeks earlier. That moment is worth a lot of confidence.

---

## Theme 6 · Observability — Sprint 6

**The gap:** you can build the system (Tracks A and B) but not answer questions about it while it's running. Senior engineers are the ones who can answer "what happened at 3pm".

| Learn | Do |
|---|---|
| Structured logging — levels, correlation IDs, what *not* to log | Convert one service's logs to structured JSON with a request ID threaded through |
| Metrics: RED (rate, errors, duration) for services, USE (utilisation, saturation, errors) for resources | Instrument one endpoint with all three RED metrics |
| Why you need percentiles, and why averages hide every outage | Plot p50/p95/p99 of something real. Watch the average stay flat while p99 explodes |
| Distributed tracing: spans, context propagation, OpenTelemetry | Trace one request across two services |
| Cardinality — the trap that makes metrics bills explode (never tag by user ID) | Compute the cardinality of a tag you were about to add |

**Deliverable:** pick a real slow period in your service. Answer "why was p99 slow at 3pm on <date>" using only your dashboards and logs — no guessing, no code reading. If you can't, the gap you just found is the deliverable.

**Ties to:** SD 1.2 latency vs throughput. Percentiles are where that lesson becomes operational.

---

## Theme 7 · Performance and profiling — Sprint 7

**The gap:** you will know Big-O cold by now, and Big-O is not why your service is slow. It's slow because of an N+1, a missing index, a lock, or a syscall in a loop.

| Learn | Do |
|---|---|
| **Measure first.** Never optimise from a hunch. Not once | Write down your guess *before* profiling. Log how often you're right — it's humbling and it's calibration data |
| `pprof` (Go), `perf` + flamegraphs (Linux), Instruments/`sample` (macOS), `py-spy`, `--cpu-prof` (Node) | Generate a flamegraph and read it. Wide bars, not tall ones |
| Latency vs throughput vs utilisation; Little's Law; why queues explode near saturation | Load-test your own service to saturation. Find the knee |
| Memory: allocations, GC pressure, cache locality, why array-of-structs beats pointer-chasing | Benchmark `vector<T>` vs `list<T>` traversal at 10M elements |
| Benchmarking honestly: warm-up, variance, `benchstat` | Never report a single run again |

**Deliverable:** make one thing at work 2× faster. Before number, after number, flamegraph, and one sentence on what dominated. Non-negotiable: **the guess you wrote down before profiling goes in the report**, right or wrong.

**Ties to:** DSA 0.4 Growth Lab, 1.5 complexity, SD 1.1.

---

## Theme 8 · Writing — Sprint 8

**The gap:** the highest-leverage skill for a 3-YOE engineer and the least practised. Engineers who write clearly get scoped bigger work, because scope is allocated based on whether people trust your thinking — and writing is how they see your thinking.

| Learn | Do |
|---|---|
| The design doc: context → problem → constraints → options considered → decision → **what it costs you** → risks → rollout | Write one for something you're about to build |
| Why "options considered and rejected" is the section that earns trust | Include the option you almost picked, and why you didn't |
| The incident postmortem: timeline, root cause, contributing factors, action items, blameless framing | Write one for a past incident, even late |
| Writing for the reader who will skim: lead with the conclusion, one idea per paragraph | Cut your first draft by 30%. Always |

**Deliverable:** write a real design doc for real upcoming work and **get it reviewed by a senior engineer**. Ask specifically: "where is my reasoning weakest?" That question is worth more than the doc.

**Ties to:** SD 5.2 tradeoff statement — *"I chose X over Y, which costs me Z."* A design doc is that sentence, expanded, with the numbers behind it.

---

## Theme 9 · Code review — Sprint 9

**The gap:** three years of reviews that said "nit: naming". Review is how you absorb a codebase and how you become visible as someone with judgement.

| Learn | Do |
|---|---|
| The review ladder: correctness → design → readability → style. **Never invert it** | Review 10 PRs, consciously walking down the ladder |
| Questions beat assertions. "What happens if this is empty?" beats "add a null check" | Phrase every comment for one week as a question |
| Reviewing your own diff before requesting review | Read your own PR as if you hated the author |
| Receiving review without defensiveness — the comment is about the code | Ask for review on something you're unsure about, on purpose |

**Deliverable:** a personal review checklist, written from the error tags in your own topic notes. Your E4 edge-case failures become the edge-case questions you ask others. Your mistakes turn into your judgement — that is the whole trick.

---

## Theme 10 · Production and on-call — Sprint 10

**The gap:** everything above is theory until something is broken at 2am and it's yours.

| Learn | Do |
|---|---|
| Safe deploys: canary, blue/green, feature flags, and **rollback as the first response** | Ship one change behind a flag. Turn it off in production on purpose |
| Incident command: stabilise first, diagnose second. Communicate every 15 min | Practise the stabilise-before-diagnose instinct — it's counterintuitive to engineers |
| SLIs, SLOs, error budgets — why 100% uptime is the wrong target | Define one SLO for a service you own |
| Graceful degradation, circuit breakers, timeouts, retries **with jitter**, idempotency | Add a timeout to a call that doesn't have one. There is one |
| Game days: break it deliberately, in daylight, with everyone watching | Kill a dependency in staging. Watch what your service does |

**Deliverable:** run a game day on your own service. Kill its database, saturate its CPU, add 500 ms of latency to a dependency. Write down what broke that you didn't predict. **The gap between what you predicted and what happened is the most valuable number in this entire document** — it is calibration, applied to systems instead of problems.

**Ties to:** SD 1.5 availability patterns, SD 6.9. And back to §1 of `PLAN.md`: prediction vs outcome, recorded, is the whole engine.

---

## The through-line

Every theme has the same shape as the DSA micro loop: **predict → attempt → diagnose → extract the general rule.** Guess before you profile. Hypothesise before you debug. Predict before the game day. Then write down the gap.

Five months of doing that produces a person who trusts their own estimates. That, and not a syllabus, is what confidence is made of.
