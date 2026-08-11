#!/bin/bash
set -e

# Scaffold a new skill directory with standard structure.
# Usage: scaffold.sh <skill-name> [--no-scripts] [--no-references]

SKILL_NAME="${1:?Usage: scaffold.sh <skill-name> [--no-scripts] [--no-references]}"
shift
INCLUDE_SCRIPTS=true
INCLUDE_REFERENCES=true

while [[ $# -gt 0 ]]; do
	case "$1" in
	--no-scripts)
		INCLUDE_SCRIPTS=false
		shift
		;;
	--no-references)
		INCLUDE_REFERENCES=false
		shift
		;;
	*)
		echo "Unknown option: $1"
		exit 1
		;;
	esac
done

# Validate name: lowercase letters, numbers, hyphens only; max 64 chars
if [[ ${#SKILL_NAME} -gt 64 ]]; then
	echo "Error: skill name must be 64 characters or fewer (got ${#SKILL_NAME})" >&2
	exit 1
fi
if [[ ! "$SKILL_NAME" =~ ^[a-z0-9][a-z0-9-]*[a-z0-9]$ ]] && [[ ! "$SKILL_NAME" =~ ^[a-z0-9]$ ]]; then
	echo "Error: skill name must contain only lowercase letters, numbers, and hyphens, and start/end with alphanumeric" >&2
	exit 1
fi

# Determine skill directory: search from cwd up to root, then try common locations
find_skill_base() {
	local dir="$1"
	for candidate in "$dir/.agents/skills" "$dir/.pi/agent/skills"; do
		if [ -d "$candidate" ]; then
			echo "$candidate"
			return 0
		fi
	done
	local parent
	parent="$(dirname "$dir")"
	if [[ "$parent" == "$dir" ]]; then
		echo ""
		return 1
	fi
	find_skill_base "$parent"
}

SKILL_BASE=$(find_skill_base "$(pwd)") || {
	echo "Error: could not find a skill base directory (.agents/skills or .pi/agent/skills) in this repo or parent dirs" >&2
	exit 1
}

SKILL_DIR="$SKILL_BASE/$SKILL_NAME"

if [ -d "$SKILL_DIR" ]; then
	echo "Error: skill directory already exists: $SKILL_DIR" >&2
	exit 1
fi

mkdir -p "$SKILL_DIR"

# Write minimal SKILL.md
cat >"$SKILL_DIR/SKILL.md" <<EOF
---
name: ${SKILL_NAME}
description: TODO — describe what this skill does and when to use it.
---

# ${SKILL_NAME}

## Overview

TODO: brief description of this skill's purpose.

## When to Use

TODO: specific triggers and use cases.

## Gotchas

TODO: common mistakes and how to avoid them.

EOF

# Optional scripts directory
if [[ "$INCLUDE_SCRIPTS" == "true" ]]; then
	mkdir -p "$SKILL_DIR/scripts"
	cat >"$SKILL_DIR/scripts/.gitkeep" <<'EOF'
# Add executable scripts here.
# Follow Unix philosophy: one script per skill, subcommands for operations,
# JSON on stdout, errors on stderr, meaningful exit codes.
EOF
fi

# Optional references directory
if [[ "$INCLUDE_REFERENCES" == "true" ]]; then
	mkdir -p "$SKILL_DIR/references"
	cat >"$SKILL_DIR/references/.gitkeep" <<'EOF'
# Add reference documentation here.
# Keep files focused — smaller files mean less context usage.
# Include a table of contents for files longer than 100 lines.
EOF
fi

echo "Scaffolded skill at: $SKILL_DIR"
echo "Next steps:"
echo "  1. Edit SKILL.md with your description, instructions, and examples"
echo "  2. Add scripts/ for executable logic (CLI-first: one script per skill)"
echo "  3. Add references/ for detailed documentation loaded on demand"
echo "  4. Test triggering by asking the agent when this skill should fire"
