# Auto-Discover Extension

This extension automatically discovers and registers models from any custom provider defined in `models.json`.

## How It Works

1. The extension reads `models.json` to find all custom providers
2. For each provider with a `baseUrl`, it fetches models from `${baseUrl}/models`
3. The discovered models replace any statically configured models for that provider
4. Models are available immediately during startup and to `pi --list-models`

## Configuration

### models.json

Define your custom providers with `baseUrl`, `apiKey`, and `api`:

```json
{
  "providers": {
    "ollama": {
      "baseUrl": "http://localhost:11434/v1",
      "api": "openai-completions",
      "apiKey": "OLLAMA_API_KEY"
    },
    "omega": {
      "baseUrl": "https://ai.n9.wtf/v1",
      "api": "openai-completions",
      "apiKey": "!pass-cli item view pass://homelab/llama-swap-api-key/password 2> /dev/null",
      "compat": {
        "supportsDeveloperRole": false,
        "supportsReasoningEffort": false
      }
    }
  }
}
```

### API Key Resolution

The extension supports three API key formats:

| Format | Example | Description |
|--------|---------|-------------|
| Environment variable | `OLLAMA_API_KEY` | Uses the value of the named env var |
| Shell command | `!pass-cli item view pass://...` | Executes command and uses stdout |
| Literal value | `sk-abc123...` | Used directly |

### settings.json

Ensure the extension is loaded:

```json
{
  "extensions": [
    "~/.config/pi/extensions/auto-discover"
  ]
}
```

## Supported APIs

The extension supports any provider that speaks a supported API:
- OpenAI Completions (most compatible)
- OpenAI Responses API
- Anthropic Messages API
- Google Generative AI

Set `api` at the provider level (default for all models) or model level (override per model).

## Notes

- The extension replaces any models defined in `models.json` for each provider
- If a provider's API key cannot be resolved, that provider is skipped
- If no models are returned from an API, that provider's models list is not updated
- The extension logs the status for each provider (skipped, discovered X models, registered X models)
