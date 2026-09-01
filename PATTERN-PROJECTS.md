# Real-Life Project For Every Pattern

One small, genuinely useful project per DSA pattern and per system design topic, mapped file-by-file to your course folders.

**Rules that make these work:**
1. **Build the project before you grind the LeetCode problems for that pattern.** Order matters. A pattern learned as a tool you needed is remembered; a pattern learned from an editorial is forgotten in nine days.
2. **Size:** 60–120 minutes each. If it's taking a full day, you're gold-plating — ship it and move on.
3. **The pattern must genuinely earn its place.** For every project, answer: *"what would break, or get slow, if I used a plain `vector` and a loop instead?"* If nothing would break, you picked a bad project — use the stretch goal instead.
4. **C++17.** Same language as the course.
5. Every project ends with a 5-line `NOTES.md`: what pattern, why it was needed, complexity of the main operation, what input size breaks it, one thing you'd do differently.

---

# PART A — DSA PATTERN PROJECTS

---

## Week 0 — Orientation

### `0.4` Complexity → **The Growth Lab**
**Real life:** your report generator was fine with 1,000 customers and takes 40 minutes at 50,000. Why?

**Build:** a benchmark harness that runs the same task — "find all duplicate IDs in a list" — three ways: nested loops O(n²), sort-then-scan O(n log n), hash set O(n). Run each at n = 1k, 5k, 10k, 50k, 100k. Print a table of milliseconds. Export CSV and chart it.

**Why the pattern is needed:** you will *see* the quadratic curve leave the screen. Nobody who has watched this forgets what O(n²) means.

**Stretch:** add a memory measurement column. Show the hash set trading space for time.

**Defense:** at what n did O(n²) become unusable, and why is the crossover point not where you predicted?

---

## Week 1 — Arrays and Lists

### `1.2` Arrays / Dynamic Arrays → **Build `MyVector` + Contact Book**
**Real life:** every language's list is this. You use it daily and don't know what it costs.

**Build:** implement `MyVector<T>` from raw `new[]`/`delete[]` — `push_back`, `pop_back`, `insert(i)`, `erase(i)`, `operator[]`, doubling growth. Instrument it to count reallocations and element copies. Then build a contact book CLI on top of it: add, delete by index, search, list.

**Why needed:** insert-at-front vs push_back on 100k contacts is the whole lesson. Print the copy count for each.

**Stretch:** compare growth factor 2x vs 1.5x on total copies for 1M push_backs. Explain amortized O(1) using your own numbers.

**Defense:** why is amortized O(1) not the same as O(1), and when would that distinction bite a real system?

**LC after:** 26, 27, 88

### `1.3` Linked Lists → **Browser History / Music Playlist**
**Real life:** back and forward buttons. Undo stacks. LRU caches.

**Build:** a doubly linked list powering a browser history: `visit(url)` (truncates forward history), `back()`, `forward()`, `showHistory()`. Then a playlist: `next`, `prev`, `shuffle`, `remove current`, `insert after current`.

**Why needed:** removing the current song from the middle is O(1) with a node pointer and O(n) with a vector. Implement both, measure at 100k songs.

**Stretch:** make the playlist circular. Then detect a cycle you accidentally created using fast/slow pointers.

**Defense:** you have the node pointer already — why is vector erase still O(n)?

**LC after:** 206, 21, 141, 876

### `1.4` Recursion → **Directory Size Analyzer (mini `du`)**
**Real life:** "my disk is full, what's eating it?"

**Build:** recursively walk a directory tree. Report total size, file count, depth, and the 10 largest files. Print an indented tree. Handle symlinks without infinite looping.

**Why needed:** a filesystem is a tree of unknown depth. Iteration needs an explicit stack; recursion is the natural fit.

**Stretch:** rewrite it iteratively with your own stack. Then find the depth at which recursion stack-overflows on your machine.

**Defense:** what is on the call stack at maximum depth, and how big is one frame?

**LC after:** 509, 344, 24

---

## Week 2 — Stack, Queue, Hash, Pointers, Windows

### `2.1` Stack → **Config File Validator + Expression Calculator**
**Real life:** every JSON/YAML parser and every compiler does exactly this.

**Build:** (a) a validator that reads a JSON-ish config file and reports *unbalanced brackets with the line and column of the offender* — not just "invalid". (b) An infix expression calculator supporting `+ - * / ( )` with correct precedence, via shunting-yard.

**Why needed:** "which opener does this closer match" is a stack question and nothing else answers it.

**Stretch:** add clear error messages: "unclosed `{` opened at line 12, column 4".

**Defense:** what does the stack *contain* at the moment of failure, and why is that exactly the error message you need?

**LC after:** 20, 155, 150

### `2.1` Queue → **Support Ticket Simulator**
**Real life:** call centres, print spoolers, request queues.

**Build:** simulate a support desk. Tickets arrive at a random rate, N agents each take T minutes per ticket. Run 8 simulated hours. Report: average wait, max wait, max queue depth, agent idle %. Try N = 2, 4, 8.

**Why needed:** FIFO fairness is the point. Show what happens to p99 wait when arrival rate approaches service rate — this is the same intuition you'll need in System Design Week 4.

**Stretch:** add a "VIP" lane — now you need two queues, or a priority queue (foreshadows Week 3).

**Defense:** at what arrival rate does average wait explode, and why isn't the transition gradual?

**LC after:** 232, 225, 622

### `2.2` Hash Tables → **Build `MyHashMap` + Log Frequency Analyzer**
**Real life:** the single most used data structure in backend work.

**Build:** implement a hash map with chaining: `put`, `get`, `remove`, `resize` at load factor 0.75. Instrument collisions and max chain length. Then use it to parse a 500k-line web access log and report: top 20 IPs, top 20 URLs, status code distribution, requests per hour.

**Why needed:** you'll see collision counts change with a good hash vs a bad one (try `hash = key[0]` deliberately and watch it degrade to a linked list).

**Stretch:** implement open addressing too. Compare on the same data. Then feed it adversarial keys that all collide.

**Defense:** when is hash lookup O(n), and how would an attacker cause that on purpose?

**LC after:** 1, 242, 49, 217

### `2.3` Two Pointers → **Duplicate File Finder**
**Real life:** disk cleanup tools.

**Build:** scan a directory, compute a hash per file, sort by (size, hash), then use two pointers to find and group all duplicate sets. Report wasted space. Add an interactive delete.

**Why needed:** on sorted data, two pointers finds groups in one pass with O(1) extra space. Compare against a hash-map approach and discuss the memory tradeoff for 10 million files.

**Stretch:** a merge tool that takes two sorted CSV exports and produces the union, intersection, and difference in a single pass.

**Defense:** the input is sorted — why does that let you drop from O(n²) to O(n)?

**LC after:** 125, 167, 15, 11

### `2.3` Sliding Window → **API Rate Limiter**
**Real life:** every public API you've ever used.

**Build:** a rate limiter answering "has this user made more than N requests in the last 60 seconds?" over a stream of timestamped requests. Implement (a) fixed window, (b) sliding window with a deque. Feed it a burst right at a window boundary and show how fixed-window lets 2N requests through and sliding-window doesn't.

**Why needed:** this is *the* canonical real use of a variable window, and the boundary bug is a genuine production incident that happens to real companies.

**Stretch:** add a "longest quiet period" report, and a per-endpoint limit using a hash map of windows.

**Defense:** why does the deque never hold more than N entries, and why is it amortized O(1) per request?

**LC after:** 3, 424, 209, 567

### `2.4` Prefix Sum → **Sales Range Query Tool**
**Real life:** analytics dashboards with date-range filters.

**Build:** load 2 years of daily revenue. Answer thousands of "total revenue between date A and date B" queries. Naive version loops each query; prefix version answers in O(1). Run 100,000 random queries and time both.

**Why needed:** the precompute-once/answer-instantly tradeoff, made visible.

**Stretch:** 2D prefix sums over a (store × day) grid for "revenue for stores 3–7 in March". Then handle updates — and discover why prefix sums are bad for mutable data (this motivates Fenwick trees later).

**Defense:** what does prefix[i] actually mean, and why does the subtraction need `prefix[l-1]` not `prefix[l]`?

**LC after:** 53, 560, 303, 238

---

## Week 3 — Trees, Heaps, Binary Search

### `3.1` Tree Traversals → **Org Chart / Filesystem Tree Renderer**
**Real life:** `tree`, company hierarchies, comment threads, the DOM.

**Build:** load an org chart from a CSV of (employee, manager). Build the tree. Then support: print indented chart (DFS pre-order), print by level "all VPs, then all directors" (BFS), total headcount under any person (post-order), find reporting chain from any employee to CEO.

**Why needed:** each question maps to a *different traversal*, and that's the entire lesson. Post-order is required for subtree totals because you need children before parent.

**Stretch:** detect a cycle in the manager data (someone reports to their own report) and report the loop.

**Defense:** why can't pre-order compute subtree headcount?

**LC after:** 94, 102, 104, 226

### `3.2` BST → **Leaderboard with Range Queries**
**Real life:** a game leaderboard, a database index.

**Build:** a BST keyed on score supporting: insert player, delete player, find rank of a player, "list all players scoring between X and Y", "top 10". Compare against sorting a vector on every query, at 100k players with 10k updates.

**Why needed:** sorted order for free, and range queries by walking the tree. This is literally what a database index does — you'll reuse this understanding in System Design Week 3.

**Stretch:** insert players in already-sorted order, watch it degrade to a linked list, measure it. Then read about balancing and explain why AVL/red-black exists. (Don't implement it — understand the need.)

**Defense:** your BST just became O(n). What input caused it and how would a DB avoid this?

**LC after:** 700, 98, 230, 235

### `3.3` Heap / Priority Queue → **Trending Topics Tracker**
**Real life:** Twitter trends, top-selling products, alert prioritization.

**Build:** stream 1 million hashtags. At any moment, report the top 10 by count — without sorting a million items. Use a hash map for counts and a size-10 min-heap for the top-K. Compare wall time against "sort everything" at each checkpoint.

**Why needed:** the min-heap-of-size-K trick is O(n log k) instead of O(n log n), and with k=10 and n=10⁶ the difference is enormous and measurable.

**Stretch:** a hospital triage simulator with a max-heap on severity, where waiting patients gain severity over time (now you need to update priorities — discover why that's awkward and what a decrease-key would give you).

**Defense:** why a *min*-heap for the top-K largest? Most people get this backwards — explain it.

**LC after:** 215, 347, 23, 703

### `3.4` Binary Search → **Log Timestamp Finder + Version Bisector**
**Real life:** finding the first error after an incident started; `git bisect`.

**Build:** (a) given a 5-million-line sorted log file, find the first entry after a given timestamp — binary search over line offsets, not a linear scan. Time both. (b) A bisect tool: given N commits and a predicate `isBroken(commit)`, find the first bad commit in log₂N tests. Print each test.

**Why needed:** part (b) teaches binary search on a *predicate*, not on an array — which is the form that shows up in hard interview problems and that most people never learn.

**Stretch:** "binary search on the answer": find the minimum number of servers needed so that no server exceeds X load, given a job list.

**Defense:** what monotonic property must hold for bisect to be valid, and what happens if it doesn't?

**LC after:** 704, 33, 153, 875

---

## Week 4 — Graphs, Sorting, Union-Find, Intervals

### `4.1` Graph BFS/DFS → **Degrees of Separation + Maze Solver**
**Real life:** LinkedIn's "2nd degree connection", routing, flood fill.

**Build:** (a) load a friendship edge list, answer "how are A and B connected?" with BFS and print the actual path. Add "people you may know" = friends-of-friends not already friends, ranked by mutual count. (b) Load an ASCII maze from a text file, find the shortest path with BFS, print it with the route drawn. Then flood-fill regions (paint bucket).

**Why needed:** BFS gives shortest path on unweighted graphs and DFS doesn't. Run both on the maze and print both paths side by side — the DFS one will be visibly, absurdly long.

**Stretch:** add walls with costs and discover you now need Dijkstra.

**Defense:** why does BFS guarantee shortest path here, and exactly where does that guarantee break?

**LC after:** 200, 133, 994, 547

### `4.2` Sorting → **Multi-Column CSV Sorter**
**Real life:** every spreadsheet, every report.

**Build:** a tool that sorts a CSV by multiple columns with directions: `sort -k dept:asc -k salary:desc`. Support string, numeric, and date columns. Then implement merge sort and quicksort yourself and compare both against `std::sort` on 1M rows.

**Why needed:** **stability** stops being trivia the moment you sort by salary and then by department and watch the salary order survive or not. Demonstrate it with real output, both ways.

**Stretch:** external sort — sort a file larger than your RAM by chunking, sorting each chunk, and k-way merging with a heap. This connects Week 3 and Week 4.

**Defense:** which of your sorts is stable, why, and when did that actually matter in your output?

**LC after:** 912, 148, 75

### `4.3` Union-Find → **Network Connectivity Monitor**
**Real life:** detecting network partitions, merging duplicate customer accounts.

**Build:** given a list of servers and links, answer "can A reach B?" as links are added *and* report the number of isolated clusters after each addition. Then: a duplicate-account merger — given pairs of records known to be the same person (matched by email, phone, or device ID), produce the final merged identity groups.

**Why needed:** incremental connectivity with near-O(1) queries. A BFS per query would be O(V+E) *every time*; run both on 100k nodes and 10k queries and watch the difference.

**Stretch:** implement without union-by-rank first, then with it, and measure tree depth on adversarial input.

**Defense:** what does path compression actually do to the tree, and why doesn't it break correctness?

**LC after:** 547, 684, 990

### `4.3` Topological Sort → **Mini Build System (`make`)**
**Real life:** make, npm, Airflow, database migrations, course prerequisites.

**Build:** read a dependency file (`app: parser utils` / `parser: lexer`), produce a valid build order, and *detect circular dependencies with the actual cycle printed*. Then simulate building with fake compile times and report total time.

**Why needed:** the cycle detection is the part everyone skips and the part that matters — a real build tool that just says "error" is useless.

**Stretch:** parallel build — group tasks into levels that can run simultaneously, and report the critical path.

**Defense:** why does a cycle make topological sort impossible, and how does your algorithm know?

**LC after:** 207, 210, 269

### `4.4` Intervals → **Meeting Room Scheduler**
**Real life:** calendar apps, resource booking, ad slot allocation.

**Build:** given a list of meetings with start/end: (a) detect all conflicts and print them, (b) merge a person's busy blocks, (c) find the minimum number of rooms needed, (d) find all free slots of ≥30 min in a workday across 5 people's calendars.

**Why needed:** part (c) is the sweep-line + min-heap combination, and part (d) is the genuinely useful one that a real product would ship.

**Stretch:** add recurring meetings. Add timezones. Watch the complexity of the *problem*, not the algorithm, explode — a good lesson.

**Defense:** why sort by start time and not end time, and what changes if you sort by end?

**LC after:** 56, 57, 435, 253

---

## Week 5 — Divide & Conquer, Backtracking, Greedy, Monotonic Stack

### `5.1` Divide & Conquer → **Large File External Sorter**
**Real life:** sorting data bigger than memory — the classic big-data primitive.

**Build:** generate a 2GB file of random records. Sort it with only 100MB of memory: split into chunks, sort each in memory, write to disk, then k-way merge with a heap. Verify the output is sorted. Report peak memory used.

**Why needed:** divide and conquer stops being an abstraction the moment memory is the constraint that forces it.

**Stretch:** count inversions in a large array with modified merge sort ("how far from sorted is this?" — a real data-quality metric).

**Defense:** why a heap for the merge instead of comparing all chunk heads each time?

**LC after:** 53 (D&C version), 169, 315

### `5.2` Backtracking → **Sudoku Solver + Exam Timetable Generator**
**Real life:** constraint solvers, scheduling, puzzle games.

**Build:** (a) a Sudoku solver that shows a step counter and can print the search tree depth. (b) An exam timetabler: N courses, M time slots, no student may have two exams at once. Find a valid assignment or prove none exists.

**Why needed:** the timetabler makes *pruning* visceral. Run it with and without the "check constraints before recursing" optimization and compare step counts — often 1000x.

**Stretch:** add the most-constrained-variable heuristic (fill the cell with fewest options first). Measure the step reduction.

**Defense:** what exactly does "undo the choice" restore, and what happens if you forget one field?

**LC after:** 78, 46, 39, 51

### `5.3` Greedy → **Cash Register + Job Scheduler**
**Real life:** change-making, CPU scheduling, ad auctions.

**Build:** (a) a cash register that makes change with the fewest coins, for USD/EUR/INR. **Then run it on the coin set {1, 3, 4} for amount 6 and watch greedy return 3 coins when 2 is possible.** (b) A job scheduler minimizing total lateness given deadlines — sort by deadline, prove it's optimal with an exchange argument.

**Why needed:** part (a) is the most important exercise in this entire week. Greedy *fails*, visibly, and you now know why you must prove it before trusting it.

**Stretch:** implement the DP version of coin change and compare answers across 20 random coin systems. Count how often greedy is wrong.

**Defense:** what property must a coin system have for greedy to be correct, and how would you test for it?

**LC after:** 55, 45, 122, 435

### `5.4` Monotonic Stack → **Stock Analytics Dashboard**
**Real life:** trading terminals, temperature dashboards, skyline rendering.

**Build:** load a year of daily prices. Compute for each day: (a) "stock span" — consecutive prior days with price ≤ today, (b) days until the next higher price, (c) the largest rectangle in a volume histogram. Naive O(n²) first, then monotonic stack O(n). Time both on 1M points.

**Why needed:** the naive version is obvious and the stack version is not — building both is the only way the trick becomes yours.

**Stretch:** the skyline problem, rendered as ASCII art.

**Defense:** what invariant does the stack maintain, and why does each element get pushed and popped at most once?

**LC after:** 739, 496, 84, 42

---

## Week 6 — Dynamic Programming

### `6.1` 1D DP → **Vacation Planner + Cell Tower Placement**
**Real life:** resource selection under constraints.

**Build:** (a) given a value for each day of a trip and a rule that you can't do activities on two consecutive days (recovery needed), maximize total value — house robber in disguise. (b) Given N houses along a road and a cost per tower, place towers to cover all houses at minimum cost.

**Why needed:** you'll write the recurrence for a problem *you* framed, which is the skill DP actually tests.

**Stretch:** add memoized recursion first, then convert to tabulation, then to O(1) space. Three versions, same answer, and explain each transformation.

**Defense:** what is the state, and how do you know it's sufficient? (This one question is 80% of DP.)

**LC after:** 70, 198, 322, 300

### `6.2` 2D DP → **File Diff Tool + Spell Checker**
**Real life:** `git diff`, autocorrect, DNA alignment, plagiarism detection.

**Build:** (a) a diff tool using longest common subsequence that prints unified-diff-style output with `+`/`-` lines for two text files. (b) A spell checker: given a dictionary and a misspelled word, suggest the 5 closest by edit distance.

**Why needed:** LCS and edit distance are the two most-asked 2D DP problems and they are *the same problem you use every day*. Diffing your own two files and seeing correct output is the moment DP stops being abstract.

**Stretch:** knapsack — a budget allocator: given projects with cost and expected value and a fixed budget, pick the optimal set. Print which projects and why.

**Defense:** in your DP table, what does cell `[i][j]` mean in plain English? If you can't say it in one sentence, you don't have the recurrence.

**LC after:** 1143, 72, 62, 416

### `6.3` Pattern Playbook → **Your Own Decision Tree**
**Not code.** Write `pattern-playbook.md` from memory, no references: for each of the 15 patterns — trigger signals, the tool, the template, the complexity, the trap, and *your own real-life project* from this list. Then have your tutor give you 25 problem statements and you name the pattern only, no solving, 30 seconds each. Score yourself. Below 20/25 means go back.

### `6.9` **FINAL MEGA PROJECT** — do the course's version, and add this integration layer

**Build a Log Analytics Engine in C++** that uses ten of these patterns in one coherent tool:

| Feature | Pattern |
|---|---|
| Parse & count entries by IP/URL | Hash map (2.2) |
| Top-K endpoints by traffic | Heap (3.3) |
| Requests in any 60s window / burst detection | Sliding window (2.3) |
| Range query "errors between 14:00 and 15:00" | Binary search on timestamps (3.4) + prefix sums (2.4) |
| Group sessions by user across devices | Union-Find (4.3) |
| Merge overlapping outage windows | Intervals (4.4) |
| Trace request → downstream service calls | Graph BFS (4.1) |
| Sort report by multiple columns | Sorting (4.2) |
| Sort a log file larger than RAM | External sort / D&C (5.1) |
| "Longest streak of healthy days" | 1D DP (6.1) |

**Deliverables:** working CLI, README with an architecture diagram, a complexity table for every operation, benchmarks at 10k / 1M / 10M lines, and a 10-minute recorded walkthrough where you justify each data structure choice.

---

# PART B — SYSTEM DESIGN PROJECTS

The rule for these: **build the tiny version.** System design knowledge that stays on a whiteboard collapses under interview pressure. Every topic gets 60–90 minutes of hands-on plus a one-page design doc.

---

## Week 0 — Orientation

### `0.3` Back-of-Envelope Math → **Capacity Calculator**
**Build:** a spreadsheet (or C++ CLI) that takes DAU, actions/user/day, payload size, read:write ratio, retention years — and outputs QPS, peak QPS (×3), storage/day, storage/5yr, bandwidth, and servers needed at 1000 QPS each.

**Then use it on three real apps you know:** WhatsApp, your bank's app, a local food delivery app. Estimate their DAU. Are your numbers plausible? Find one published real figure and check.

**Deliverable:** `design-docs/00-capacity.md` with your three estimates and what surprised you.

**Defense:** which single input assumption changes your answer the most, and how would you reduce that uncertainty?

---

## Week 1 — Foundations & Tradeoffs

### `1.1–1.2` Performance vs Scalability, Latency vs Throughput → **Load Test Your Own Server**
**Build:** a trivial HTTP server (or reuse a hello-world one). Load test it with increasing concurrency: 1, 10, 50, 100, 500 concurrent clients. Chart throughput (req/s) and latency (p50, p95, p99) against concurrency.

**What you'll see:** throughput rises then plateaus while latency climbs vertically. **That chart is the answer to "what's the difference between latency and throughput" for the rest of your career.** Find your knee point.

**Stretch:** add a 50ms artificial delay per request. Re-run. Explain the new shape using Little's Law.

**Defense:** your p50 is fine and your p99 is terrible. What does that tell you about where the problem is?

### `1.3–1.4` CAP & Consistency → **Two-Node Key-Value Store**
**Build:** two tiny KV servers that replicate writes to each other. Then **cut the link between them** (kill the replication, or just block the port). Now:
- **CP mode:** refuse writes when the peer is unreachable. Measure the downtime.
- **AP mode:** accept writes on both sides. Restore the link. Now you have a conflict — resolve it (last-write-wins, and observe the data you silently destroyed).

**Why this matters:** you will never again describe CAP as a vague triangle. You'll have deleted your own data with LWW.

**Deliverable:** `design-docs/01-cap.md` — what you built, the conflict you created, the write you lost, and which mode you'd choose for a bank vs a like-counter.

**Defense:** what did last-write-wins actually mean when both clocks were slightly off?

### `1.5` Availability Patterns → **Failover Demo**
**Build:** two identical service instances behind a script that health-checks every second and routes to the healthy one. Kill the primary mid-request-stream. Measure: how many requests failed, and how long until traffic recovered.

**Stretch:** compute the theoretical availability of your setup in nines, then compare with the downtime you actually measured over 10 kill cycles.

---

## Week 2 — Networking & Traffic

### `2.1` DNS → **Trace a Resolution End to End**
**Build:** use `dig +trace` on a popular domain and document every hop: root → TLD → authoritative. Record TTLs. Then flush your cache and time a cold vs warm resolution. Finally, add an entry to `/etc/hosts` and observe it winning over DNS entirely.

**Deliverable:** a diagram of the resolution path with real timings from your machine.

**Defense:** you changed a DNS record and some users still hit the old server for hours. Why, and what would you have done differently before the change?

### `2.2` CDN → **Origin vs Edge Simulation**
**Build:** serve a 5MB image from a local "origin" server with an artificial 200ms delay. Put a caching proxy (nginx with `proxy_cache`, or your own) in front. Measure first request vs subsequent. Then invalidate and re-measure.

**Stretch:** implement push vs pull CDN behavior and articulate when each wins.

**Defense:** you deployed new CSS and users see the old page. Walk through every cache layer between your server and their eyes.

### `2.3–2.4` Load Balancer & Reverse Proxy → **Build the Real Thing**
**Build:** run 3 backend instances that each log their own ID. Put nginx in front as a reverse proxy + load balancer. Implement/configure and *observe* round-robin, least-connections, and IP-hash. Kill one backend and watch health checks remove it. Bring it back.

**Then break it deliberately:** make one backend slow (5s responses) and watch round-robin keep sending it traffic. Switch to least-connections and watch the behavior change.

**Deliverable:** `design-docs/02-lb.md` with your observations and a session-stickiness discussion — what breaks when a user's session lives in one server's memory?

**Defense:** L4 vs L7 load balancing — what can L7 do that L4 can't, and what does it cost?

### `2.5` Microservices → **Split a Monolith**
**Build:** take a small monolith (users + orders + notifications in one process). Split it into three services talking over HTTP. Now experience the consequences: what happens when notifications is down? What happens to a "create order" that must also decrement inventory — where did your transaction go?

**Deliverable:** a written comparison of what got better and what got worse. Be honest — for a small app, mostly worse. Say so and say when the tradeoff flips.

**Defense:** you now have a distributed transaction problem. Name two ways to handle it and their costs.

---

## Week 3 — Databases

### `3.1` RDBMS & Scaling → **Index Lab + Read Replica**
**Build:** load 5M rows into Postgres. Run a query on an unindexed column, `EXPLAIN ANALYZE` it. Add the index. Re-run. Record both plans and both times. Then: add a composite index and show a query that uses it and one that doesn't (wrong column order). Measure write slowdown with 5 indexes vs 0.

**Then:** set up a read replica. Write to primary, read from replica, and *measure replication lag* under load. Write then immediately read — catch the stale read.

**Deliverable:** `design-docs/03-indexes.md` with real query plans before/after, and your write-amplification numbers.

**Defense:** when does adding an index make the system slower overall?

### `3.1` Sharding → **Manual Shard Router**
**Build:** three separate database instances. A router that sends each user's data to `shard = hash(user_id) % 3`. Implement: write, read, and a cross-shard query ("top 10 users overall") — feel the pain of the last one.

**Then add a fourth shard** and discover you have to move ~75% of your data. *Now* implement consistent hashing and re-measure how much moves.

**Defense:** what query pattern would make your shard key a disaster, and how would you pick a better one?

### `3.2–3.3` NoSQL & SQL vs NoSQL → **Same Feature, Two Stores**
**Build:** implement "user activity feed" twice — once in Postgres with joins, once in a document store (or Redis with denormalized JSON). Load the same 1M records. Compare: write throughput, read latency, storage size, and *how much code each took*. Then change a requirement ("also show the author's current display name") and see which one suffers.

**Deliverable:** a one-page recommendation with numbers, not opinions.

**Defense:** you denormalized and now a user renamed themselves. What's your update path and what's the cost?

---

## Week 4 — Caching & Asynchronism

### `4.1–4.2` Caching & Update Strategies → **Cache-Aside With Real Numbers**
**Build:** put Redis in front of your Postgres read path. Instrument hit rate, p50/p99 latency with cache on and off, and DB QPS with cache on and off.

**Then implement and compare:** cache-aside, write-through, write-behind. For each, deliberately create a stale read and document how it happened.

**Then break it:** simulate a **cache stampede** — expire a hot key while 100 concurrent requests want it. Watch the DB take 100 identical queries. Fix it (locking, or stale-while-revalidate) and re-measure.

**Deliverable:** `design-docs/04-caching.md` with a table: strategy × consistency × latency × complexity.

**Defense:** your cache hit rate is 99% and the site still falls over when Redis restarts. Explain.

### `4.3` Asynchronism → **Job Queue**
**Build:** a task queue (Redis list or a simple in-process one) where the API returns `202 Accepted` immediately and a worker processes "send email" / "generate report" in the background. Add: retry with exponential backoff, a dead-letter queue after 3 failures, and a status endpoint the client can poll.

**Then:** make workers slower than producers. Watch the queue depth grow. This is *backpressure*, and it's the same lesson as the ticket simulator in DSA Week 2.

**Deliverable:** a chart of queue depth over time with 1, 2, and 4 workers.

**Defense:** your worker crashed halfway through a job. Did the user get two emails, or none? Design for the answer you want.

---

## Week 5 — Communication & Security

### `5.1` HTTP → **Raw Socket HTTP Server**
**Build:** in C++, a server using raw sockets that parses HTTP requests by hand — request line, headers, body. Serve `GET /health` and `POST /data`. Return correct status codes. Handle a malformed request without crashing. Capture your own traffic with `tcpdump` and read the raw bytes.

**Then:** implement keep-alive and measure the difference across 1000 sequential requests vs new connection each time.

**Defense:** what exactly does `Content-Length` protect you from, and what happens with chunked encoding instead?

### `5.2` TCP vs UDP → **Two Chat Clients**
**Build:** the same tiny chat app twice — TCP and UDP. Then use a network emulator (or just drop packets randomly in your own send function) at 5% loss. TCP recovers; UDP loses messages. Measure latency of each under loss.

**Defense:** name one real system that correctly chooses UDP and explain what it does instead of retransmission.

### `5.3` RPC & REST → **Same API, Two Ways**
**Build:** an endpoint implemented as REST/JSON and as gRPC/protobuf. Compare: payload size on the wire, requests/second, and how each handles adding a new field (schema evolution).

**Defense:** when is REST the right call despite being slower?

### `5.4` Security → **Attack Your Own Server**
**Build:** take your API from earlier weeks and add: password hashing with bcrypt (then show why plain SHA-256 is not enough), JWT auth, HTTPS with a self-signed cert, rate limiting (reuse your DSA Week 2 sliding window!), and input validation.

**Then attack it yourself:** SQL injection on an unparameterized query (make one on purpose, exploit it, then fix it), a replay attack with a stolen token, and a brute-force login run.

**Deliverable:** `design-docs/05-security.md` — each attack, whether it worked, and the fix.

**Defense:** your JWT is stolen. What's your blast radius and how do you shrink it?

### `5.5` Object-Oriented Design → **Parking Lot / Elevator in C++**
**Build:** the classic OOD interview questions, in real code: a parking lot (multiple levels, vehicle sizes, pricing, availability) or an elevator bank (multiple cars, request scheduling, direction logic). Classes, interfaces, and a working simulation — not just a UML diagram.

**Defense:** where did you use polymorphism and would a plain enum have been simpler? Be honest.

---

## Week 6 — Designs & Mega Project

For each design file `6.2`–`6.8`, follow this loop:

1. **Attempt cold, 45 minutes, timed, before reading the file.** Draw it. Do the math. Write the API. This attempt is the learning — reading first destroys it.
2. Read the course's solution.
3. Write `design-docs/06-N-<name>-delta.md`: what you missed, what you got right, and the *one insight* you'll carry forward.
4. Redraw from memory 3 days later.

**Then build one, small but end-to-end** — I recommend `6.2` **Pastebin/Bitly**, because everything you've built this course plugs into it:

| Component | Comes from |
|---|---|
| Base62 short code generation + collision handling | Hash map (DSA 2.2) |
| Postgres schema + index on short_code | SD 3.1 |
| Redis cache-aside for hot links | SD 4.1 |
| Rate limiting per IP | Sliding window (DSA 2.3) |
| Top 10 most-clicked links | Heap (DSA 3.3) |
| Click analytics by time range | Prefix sums / binary search (DSA 2.4, 3.4) |
| Async click-event processing | Job queue (SD 4.3) |
| nginx load balancing 2 instances | SD 2.3 |
| Auth + input validation | SD 5.4 |

**Final deliverable:** working system, architecture diagram, capacity math for 100M URLs and 10K QPS, a load test showing your actual limit, a list of what breaks first at 10x, and a 15-minute recorded design presentation given from a blank whiteboard.

---

## Master Checklist

**DSA — projects shipped**
- [ ] 0.4 Growth Lab
- [ ] 1.2 MyVector + Contact Book
- [ ] 1.3 Browser History / Playlist
- [ ] 1.4 Directory Analyzer
- [ ] 2.1 Config Validator + Calculator
- [ ] 2.1 Ticket Simulator
- [ ] 2.2 MyHashMap + Log Analyzer
- [ ] 2.3 Duplicate File Finder
- [ ] 2.3 Rate Limiter
- [ ] 2.4 Sales Range Query
- [ ] 3.1 Org Chart Renderer
- [ ] 3.2 Leaderboard BST
- [ ] 3.3 Trending Topics
- [ ] 3.4 Log Finder + Bisector
- [ ] 4.1 Degrees of Separation + Maze
- [ ] 4.2 CSV Sorter
- [ ] 4.3 Connectivity Monitor
- [ ] 4.3 Mini Build System
- [ ] 4.4 Meeting Scheduler
- [ ] 5.1 External Sorter
- [ ] 5.2 Sudoku + Timetabler
- [ ] 5.3 Cash Register + Job Scheduler
- [ ] 5.4 Stock Dashboard
- [ ] 6.1 Vacation Planner
- [ ] 6.2 Diff Tool + Spell Checker
- [ ] 6.3 Pattern Playbook (from memory)
- [ ] 6.9 Log Analytics Engine (MEGA)

**System Design — projects shipped**
- [ ] 0.3 Capacity Calculator
- [ ] 1.1 Load Test Chart
- [ ] 1.3 Two-Node KV (CP vs AP)
- [ ] 1.5 Failover Demo
- [ ] 2.1 DNS Trace
- [ ] 2.2 CDN Simulation
- [ ] 2.3 nginx LB Lab
- [ ] 2.5 Monolith Split
- [ ] 3.1 Index Lab + Replica
- [ ] 3.1 Shard Router
- [ ] 3.2 Same Feature, Two Stores
- [ ] 4.1 Cache-Aside + Stampede
- [ ] 4.3 Job Queue + Backpressure
- [ ] 5.1 Raw Socket HTTP Server
- [ ] 5.2 TCP vs UDP Chat
- [ ] 5.3 REST vs gRPC
- [ ] 5.4 Attack Your Own Server
- [ ] 5.5 Parking Lot / Elevator OOD
- [ ] 6.2–6.8 Seven cold design attempts + deltas
- [ ] 6.10 Bitly End-to-End (MEGA)
