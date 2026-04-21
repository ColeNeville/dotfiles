# Auto-Discover Extension

This extension automatically discovers and registers models from the Omega provider's API endpoint.

## Configuration

### 1. models.json

Define the omega provider WITHOUT models:

```json
{
  "providers": {
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

### 2. Environment Variable

Set the `OMEGA_API_KEY` environment variable:

```bash
export OMEGA_API_KEY=your-api-key
```

Or use the `!pass-cli` format in models.json to fetch the key:

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

1. On startup, the extension checks if `OMEGA_API_KEY` is configured
2. It fetches models from `${baseUrl}/models`
3. Registers the discovered models, replacing any statically configured models
4. Models are available immediately during startup and to `pi --list-models`

## Notes

- The extension replaces any models defined in `models.json` for the omega provider
- If no models are returned from the API, the extension fails gracefully and doesn't register any models
- The extension logs the number of discovered and registered models
