# Model Alias Extension

Reads semantic model aliases from `models.json` and registers each alias as a
registerable provider/model. Subagent configs can use generic names like
`--model code` regardless of environment.

## Config Format

Add an `aliases` top-level key to your `models.json`:

```json
{
  "aliases": {
    "code": {
      "targetProvider": "omega",
      "targetModel": "qwen3.6-35b-a3b"
    },
    "chat": {
      "targetProvider": "omega",
      "targetModel": "qwen3.5-122b-a10b"
    },
    "fast": {
      "targetProvider": "omega-open-webui",
      "targetModel": "qwen36-35b-a3b-coder"
    }
  },
  "providers": { ... }
}
```

### Minimal Alias

Only `targetProvider` and `targetModel` are required. The alias inherits all
metadata (reasoning, contextWindow, maxTokens, input, cost) from the target
provider's model entry in `models.json`.

```json
{
  "aliases": {
    "code": {
      "targetProvider": "omega",
      "targetModel": "qwen3.6-35b-a3b"
    }
  }
}
```

### Alias with Metadata Override

Override specific metadata fields on the alias:

```json
{
  "aliases": {
    "code": {
      "targetProvider": "omega",
      "targetModel": "qwen3.6-35b-a3b",
      "maxTokens": 32768
    }
  }
}
```

### Supported Override Fields

| Field              | Type     | Description                                              |
| ------------------ | -------- | -------------------------------------------------------- |
| `reasoning`        | boolean  | Override target model's reasoning support                |
| `input`            | string[] | Override input types (`["text"]` or `["text", "image"]`) |
| `contextWindow`    | number   | Override context window size in tokens                   |
| `maxTokens`        | number   | Override maximum output tokens                           |
| `cost`             | object   | Override per-million-token costs                         |
| `thinkingLevelMap` | object   | Override thinking level mapping                          |
| `compat`           | object   | Override provider compatibility flags                    |

## Requirements

- **All models must be explicitly defined** in the `providers` section of
  `models.json`. Aliases cannot target built-in models that aren't in
  `models.json`.
- **OAuth targets are not supported**. If a target provider has no `apiKey`
  in `models.json`, the alias is skipped with a warning.
- **Auth is auto-resolved** from the target provider's `models.json` config.
  No duplication needed.

## How It Works

1. Extension reads `~/.pi/agent/models.json` at startup
2. Parses the `aliases` top-level key
3. For each alias:
   - Resolves `baseUrl` from target provider config (or hardcoded default)
   - Resolves `apiKey` from target provider config
   - Looks up target model metadata from provider's `models[]` array
   - Applies any alias-level metadata overrides
   - Registers as a new provider (`alias-<name>/<alias>`)
4. Alias models appear in `--list-models` and can be used with `--model <name>`

## Hot-Reload

Extension reads `models.json` once at factory time. Changes require `/reload`.

## Limitations

- Aliases appear as separate providers in the UI (`alias-code/code`)
- Built-in models not in `models.json` are not supported
- OAuth-only providers are not supported
- Unknown target providers default to `openai-completions` with a warning
