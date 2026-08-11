# Skill Validation Checklist

Pre-merge validation checklist for agent skills. Use before committing a new or updated skill.

## Core Quality

- [ ] **Description is specific** and includes key terms the agent would match against
- [ ] **Description includes both what and when** — not just a summary
- [ ] **Description is in third person** — "Processes X" not "I can help you X"
- [ ] **Description includes negative triggers** — "Do NOT use for X"
- [ ] **SKILL.md body is under 500 lines**
- [ ] **Additional details are in separate files** (references/, assets/) when approaching the limit
- [ ] **No time-sensitive information** — or it's in a clearly marked "old patterns" section
- [ ] **Consistent terminology** throughout
- [ ] **Examples are concrete**, not abstract
- [ ] **File references are one level deep** — no nested references
- [ ] **Progressive disclosure is used** — essential in L2, optional in L3
- [ ] **Workflows have clear steps** — numbered, with expected outputs

## File Structure

- [ ] **Directory name matches `name` field** in frontmatter
- [ ] **SKILL.md exists** at the root of the skill directory
- [ ] **YAML frontmatter is valid** — parseable by standard YAML parsers
- [ ] **Name field** contains only lowercase letters, numbers, and hyphens
- [ ] **Name field** is 64 characters or fewer
- [ ] **Description field** is 1024 characters or fewer
- [ ] **No XML tags** in frontmatter values
- [ ] **Forward slashes** in all file paths (no backslashes)
- [ ] **Optional metadata fields** (license, compatibility, metadata) are present if needed by your harness

## Scripts (if applicable)

- [ ] **Scripts solve problems** rather than defer to the agent
- [ ] **Error handling is explicit and helpful** — meaningful error messages, non-zero exit codes
- [ ] **No "voodoo constants"** — all magic numbers/values are justified with comments
- [ ] **Required packages are listed** in instructions and verified as available
- [ ] **Scripts have clear documentation** — usage, options, examples
- [ ] **No Windows-style paths** — all forward slashes
- [ ] **Validation/verification steps** for critical operations
- [ ] **Feedback loops included** for quality-critical tasks
- [ ] **Scripts follow Unix philosophy** — one script per skill, subcommands, JSON on stdout

## Content Quality

- [ ] **Instructions are a delta from baseline** — only include team conventions, domain rules, and edge cases the model would get wrong
- [ ] **Critical instructions are first** — not buried in the middle
- [ ] **A `## Gotchas` section exists** — naming the mistake and the correct alternative
- [ ] **Templates and examples** are included where helpful
- [ ] **Decision trees** are clear with explicit fallbacks
- [ ] **Exit conditions** are defined for iterative/refinement workflows

## Testing

- [ ] **Triggering tested** — ask "When would you use the `<name>` skill?" and verify the agent quotes your trigger phrases
- [ ] **Functional correctness tested** — consistent outputs across 3–5 runs
- [ ] **Edge cases tested** — empty input, malformed data, boundary conditions
- [ ] **Negative cases tested** — queries that should NOT trigger the skill
- [ ] **Performance baseline captured** — tool calls, messages, tokens with vs. without the skill

## Security

- [ ] **No hardcoded credentials** — use environment variables
- [ ] **Input validation** present for any user-provided data
- [ ] **Human confirmation required** for state-altering actions
- [ ] **Models instructed to ignore embedded commands** from external data
- [ ] **Network access is restricted** to approved destinations (if applicable)

## Documentation

- [ ] **README or top-level docs** updated if this skill introduces a new pattern
- [ ] **CHANGELOG or release notes** updated if this is a significant change
- [ ] **Related skills documented** — how this skill composes with others
