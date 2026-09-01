# Pattern Cards

> One card per pattern, **written by you, in your own words**, at the moment you first meet it. 5 minutes.
>
> **If you can't write the card, you haven't learned the pattern.** Cards written by an AI do not count and you will know the difference when you reread them in December.
>
> The `MY SENTENCE` line is the test. If you can't compress it to one sentence, keep working.

---

## Template

```markdown
## <Pattern name>
TRIGGER:    <what in the input tells you to reach for this>
TOOL:       <the data structure / technique>
TEMPLATE:   <the shape of the code, in prose>
COMPLEXITY: <time and space, and why>
TRAP:       <the mistake you personally made>
REAL-LIFE:  <the project from PATTERN-PROJECTS.md where you needed it>
MY SENTENCE: "<one sentence, your words, no jargon you can't unpack>"
```

---

## Worked example (this one is from AGENT.md — replace it with your own version after Sprint 2)

```markdown
## Sliding Window (variable size)
TRIGGER:    contiguous subarray/substring + "longest / shortest / at most K"
TOOL:       two indices + a hash map or counter of window contents
TEMPLATE:   expand right always; shrink left while invalid; record answer when valid
COMPLEXITY: O(n) — each index moves forward at most n times, never backward
TRAP:       moving left backward; recording the answer inside the shrink loop
REAL-LIFE:  API rate limiter — "max requests in any 60-second window"
MY SENTENCE: "The window is the set of things currently allowed; I grow it greedily
              and shrink it only when it breaks a rule."
```

---

## Cards

<!-- yours below -->

## Checklist — 26 cards by 31 Jan

**Week 1** ☐ dynamic array ☐ linked list ☐ recursion
**Week 2** ☐ stack ☐ queue ☐ hash map ☐ two pointers ☐ sliding window ☐ prefix sum
**Week 3** ☐ tree traversal ☐ BST ☐ heap ☐ binary search
**Week 4** ☐ BFS ☐ DFS ☐ union-find ☐ topological sort ☐ intervals ☐ sorting
**Week 5** ☐ divide & conquer ☐ backtracking ☐ greedy ☐ monotonic stack
**Week 6** ☐ 1D DP ☐ 2D DP ☐ the decision tree that picks between all of the above
