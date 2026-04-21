---
name: code-reviewer
description: |
  Thoroughly reviews code changes for bugs, security vulnerabilities,
  performance issues, style consistency, and architectural soundness.
  Use when reviewing diffs, PRs, or new files before merging.
---

# Code Reviewer Skill

Thoroughly review any code changes you're asked about. Be constructive but rigorous — catching issues early saves hours of debugging later.

## When to Use

- Before merging a pull request or commit
- When asked to "review" or "take a look at" code
- After writing or editing code (self-review)
- Comparing two versions of a file (use `git diff` to get the diff)
- Reviewing a proposed change before implementation

## Review Checklist

Apply each category below. Not every item applies to every review — use judgment.

### 1. Correctness & Bugs

- [ ] Does the code do what it claims to do?
- [ ] Are edge cases handled (empty input, null/undefined, zero, negative)?
- [ ] Are error paths covered? What happens when a dependency fails?
- [ ] Are there off-by-one errors, race conditions, or timing issues?
- [ ] Do types/interfaces match usage throughout the call chain?

### 2. Security

- [ ] **Input validation**: Is all external input sanitized?
- [ ] **AuthN/AuthZ**: Are permissions checked at every protected boundary?
- [ ] **Secrets**: Are credentials hardcoded, committed, or logged anywhere?
- [ ] **Injection**: SQL, XSS, command injection — are params properly escaped/parameterized?
- [ ] **Dependencies**: Any known vulnerable packages? Pin versions.
- [ ] **File access**: Path traversal possible? Validate all file paths.

### 3. Performance

- [ ] N+1 queries or repeated DB calls in loops?
- [ ] Unnecessary allocations, string concatenation in hot paths?
- [ ] Missing pagination, filtering, or caching for large datasets?
- [ ] Blocking I/O in async/event-loop contexts?
- [ ] Memory leaks: unclosed connections, missing cleanup, growing caches?

### 4. Style & Readability

- [ ] Consistent naming (variables, functions, files) with project conventions
- [ ] Functions should do one thing; keep them short (< 30–50 lines ideal)
- [ ] No duplicated logic — extract shared code
- [ ] Comments explain *why*, not *what*. The code itself should be clear
- [ ] Follows the project's linting/formatting rules
- [ ] Import/dependency order is clean and consistent

### 5. Architecture & Design

- [ ] Does this follow the project's existing patterns?
- [ ] Is there a simpler way? (KISS)
- [ ] Are abstractions justified, or are we over-engineering?
- [ ] Is error handling centralized or consistently applied?
- [ ] Does this change create unnecessary coupling between modules?

### 6. Testing

- [ ] Are new tests written for new functionality?
- [ ] Do existing tests still pass (or do they need updating)?
- [ ] Are there meaningful assertions, not just "no exception thrown"?
- [ ] Edge cases have test coverage?
- [ ] Integration/e2e tests for API or user-facing changes?

## How to Review

1. **Understand the intent** — What is this code trying to achieve?
2. **Read every line** — Don't skim. Context matters.
3. **Trace data flow** — Follow inputs through to outputs.
4. **Compare with existing code** — Does it fit? Is there precedent?
5. **Think about maintainability** — Can a new team member understand this in 6 months?
6. **Prioritize feedback** — Blockers first, then suggestions.

## Feedback Format

When reporting issues, structure your feedback like this:

```
## Summary
[Brief assessment: looks good, needs changes, or critical blockers]

## Issues
### 🔴 Critical (must fix before merge)
- **File:Line** — Description + suggested fix

### 🟡 Concerns (should address)
- **File:Line** — Description + suggestion

### 💡 Suggestions (nice to have)
- **File:Line** — Observation or improvement idea
```

## Tips

- Be specific about file and line numbers when possible.
- Suggest concrete fixes rather than vague complaints.
- Praise good patterns — positive reinforcement matters too.
- If something feels off but you can't pinpoint why, say so. Sometimes intuition catches subtle issues.
- When in doubt, ask "what happens if…" — this reveals edge cases.

