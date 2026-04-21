# Auto-Discover Extension

This extension automatically discovers and registers models from custom provider API endpoints.

## Supported Providers

The extension includes built-in support for:

| Provider | Base URL | Environment Variable |
|----------|----------|---------------------|
| Ollama | `http://localhost:11434/v1` | `OLLAMA_API_KEY` |
| LM Studio | `http://localhost:1234/v1` | `LM_STUDIO_API_KEY` |
| vLLM | `http://localhost:8000/v1` | `VLLM_API_KEY` |
| Omega | `https://ai.n9.wtf/v1` | `OMEGA_API_KEY` |

## Adding Custom Providers

To add support for a new provider, add it to the `providers` array in `index.ts`:

```typescript
{
  name: "my-provider",
  baseUrl: "https://my-provider.com/v1",
  apiKeyEnv: "MY_PROVIDER_API_KEY"
}
```

## Configuration

### 1. models.json

Define each provider WITHOUT models (only baseUrl, apiKey, api):

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
      "apiKey": "OMEGA_API_KEY",
      "compat": {
        "supportsDeveloperRole": false,
        "supportsReasoningEffort": false
      }
    }
  }
}
```

### 2. Environment Variables

Set the API key environment variables:

```bash
export OLLAMA_API_KEY=your-ollama-api-key
export OMEGA_API_KEY=your-omega-api-key
# Add more as needed
```

Or use shell commands in models.json:

```json
{
  "providers": {
    "omega": {
      "apiKey": "!pass-cli item view pass://homelab/llama-swap-api-key/password 2> /dev/null"
    }
  }
}
```

### 3. settings.json

Ensure the extension is loaded:

```json
{
  "extensions": [
    "~/.config/pi/extensions/auto-discover"
  ]
}
```

## How It Works

1. On startup, the extension iterates through all configured providers
2. For each provider, it checks if the API key environment variable is set
3. If the API key is configured, it fetches models from `${baseUrl}/models`
4. The extension registers the discovered models, replacing any statically configured models
5. Models are available immediately during startup and to `pi --list-models`

## Notes

- The extension replaces any models defined in `models.json` for each provider
- If a provider's API key is not configured, that provider is skipped
- If no models are returned from an API, that provider's models list is not updated
- The extension logs the status for each provider (skipped, discovered X models, registered X models)
