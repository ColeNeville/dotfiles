# Common Mistakes in Skill Authoring

Real-world pitfalls and corrections, gathered from production skills across Anthropic, OpenAI, PostHog, and Red Hat.

## Mistake 1: Vague Description

**Symptom:** Skill never triggers, or triggers inconsistently.

```yaml
# Bad — too vague
description: >
  Helps with analytics and data tasks.
```

```yaml
# Good — specific triggers and capabilities
description: >
  Query PostHog analytics data using HogQL. Use when the user asks
  to analyze trends, run queries, or extract metrics from PostHog.
  Supports event tracking, funnel analysis, and retention queries.
```

**Fix:** Add specific trigger phrases users would actually say. Mention relevant file types, tools, or output formats.

---

## Mistake 2: Overly Broad Description

**Symptom:** Skill triggers on unrelated queries.

```yaml
# Bad — too broad, catches everything
description: >
  Handles all data processing and transformation tasks.
```

```yaml
# Good — scoped with negative triggers
description: >
  Transform CSV and TSV files into structured JSON. Use when the user
  asks to convert CSV to JSON, parse tabular data, or restructure
  spreadsheet exports. Do NOT use for database queries, API calls,
  or image processing.
```

**Fix:** Add negative triggers. Narrow the scope to one clear job.

---

## Mistake 3: Instructions Too Verbose

**Symptom:** Skill loads but instructions are ignored or partially followed.

```markdown
# Bad — everything is equally important, nothing stands out

## Introduction
This skill does many things. Here is a long introduction about how
skills work and why they are important and how they help agents...

## Detailed Explanation
Here is a very long explanation of every possible scenario...

## More Details
And even more details about edge cases...

## Steps
1. Do this
2. Do that
3. ...
```

```markdown
# Good — critical instructions first, detail gated

## Overview
Convert CSV to JSON. One command, clear output.

## Workflow
1. Read the CSV file
2. Parse headers as keys
3. Output JSON array to stdout
4. Write to `.output.json`

## Gotchas
- Headers with spaces are replaced with underscores
- Empty rows are skipped

## References
- `references/schema.md` — full type mapping
- `references/examples.md` — sample inputs and outputs
```

**Fix:** Put critical instructions first. Move detail to references/. Default assumption: the agent is already smart.

---

## Mistake 4: SKILL.md Too Large

**Symptom:** Token usage spikes, performance degrades.

**Fix:** Split into references/ files. Use progressive disclosure.

| Move to references/ | Keep in SKILL.md |
| --------------------- | ------------------ |
| Full API reference | API overview and when to use which endpoint |
| Complete data schemas | Key fields and common patterns |
| Extensive examples | 2–3 representative examples |
| Historical context | Current best practices |
| Alternative approaches | Recommended approach |

---

## Mistake 5: Too Many Skills

**Symptom:** Skills compete with each other for context budget. Agent gets confused.

**Fix:**

- Prefer a small set of focused skills with rich references/ over many thin ones
- One skill per distinct trigger/use case
- If two skills share the same diagnosis or trigger, merge them
- Add detail to references/ before creating a new skill

---

## Mistake 6: Hardcoding Harness-Specific Behavior

**Symptom:** Skill works in one harness but not another.

**Fix:**

- Keep logic scripts separate from harness-specific prompts
- Hardcode sequential steps rather than relying on the agent to chain them
- Use forward slashes in all paths
- Test across harnesses if distributing

---

## Mistake 7: Embedding Credentials or Secrets

**Symptom:** Security vulnerability, credentials exposed in logs or context.

**Fix:**

- Use environment variables for all credentials
- Validate inputs to prevent injection
- Instruct models to ignore embedded commands from external data

---

## Mistake 8: No Gotchas Section

**Symptom:** Agent makes plausible but wrong decisions repeatedly.

**Fix:** Add a `## Gotchas` section. Each entry should name:

1. The plausible mistake
2. The correct alternative

Build this section incrementally from real failures, not from speculation.

---

## Mistake 9: No Testing

**Symptom:** Skill works once, breaks on follow-up runs. No regression signal.

**Fix:**

- Build 2–3 test cases covering casual language, precise language, and boundary conditions
- Test triggering, functional correctness, and performance
- Capture performance baselines (tool calls, messages, tokens)
- Run regression tests before merging updates

---

## Mistake 10: Solving, Not Deferring

**Symptom:** SKILL.md asks the agent to write code it should just run.

```markdown
# Bad — agent has to write the validation logic
## Validation
Write a Python script to validate the input, then run it.
```

```markdown
# Good — script handles validation
## Validation
Run `scripts/validate.sh --input $FILE`. It checks format, required fields, and type constraints.
```

**Fix:** Scripts are cheap, transparent, and testable. Use them for mechanical tasks.
