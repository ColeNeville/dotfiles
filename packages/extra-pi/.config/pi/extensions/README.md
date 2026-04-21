# Pi Extensions

This directory contains TypeScript extensions for the pi coding agent.

## Available Extensions

### auto-discover/

Contains extensions for automatic model discovery.

#### index.ts

Automatically discovers and registers models from custom provider API endpoints.

**Supported providers:**
- Ollama (http://localhost:11434/v1)
- LM Studio (http://localhost:1234/v1)
- vLLM (http://localhost:8000/v1)
- Omega (https://ai.n9.wtf/v1)

**See:** [auto-discover/README.md](auto-discover/README.md) for full configuration details.

## Adding Custom Extensions

### Single File Extensions

Create a `.ts` file in this directory:

```typescript
import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";

export default function (pi: ExtensionAPI) {
  // Your extension code here
}
```

### Subdirectory Extensions

Create a directory with an `index.ts` entry point:

```
extensions/
└── my-extension/
    ├── index.ts        # Entry point (exports default function)
    └── utils.ts        # Helper module
```

```typescript
// index.ts
export default async function (pi: ExtensionAPI) {
  // Async initialization (e.g., fetch remote config)
}
```

## Configuration

Update `settings.json` to include extension paths in the `extensions` array:

```json
{
  "extensions": [
    "~/.config/pi/extensions/discover-models.ts",
    "~/.config/pi/extensions/auto-discover",
    "~/.config/pi/extensions/my-extension"
  ]
}
```

## See Also

- [Pi Extensions Documentation](https://pi.coding-agent.dev/docs/extensions)
- [Pi Examples](https://github.com/badlogic/pi-mono/tree/main/packages/coding-agent/examples/extensions)
