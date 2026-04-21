import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";

/**
 * Extension for automatic model discovery from custom provider endpoints.
 * 
 * This extension reads all custom providers from models.json and fetches
 * their models dynamically from their respective /models endpoints.
 * It updates the model list for each provider, replacing any statically
 * configured models.
 * 
 * Usage:
 * - Define custom providers in models.json with baseUrl, apiKey, api
 * - Set the corresponding API key environment variables
 * - The extension will automatically discover and register models for each provider
 */
export default async function (pi: ExtensionAPI) {
  // List of providers to discover models for
  // Each provider needs:
  // 1. Its baseUrl configured in models.json
  // 2. Its API key set as environment variable (e.g., PROVIDER_NAME_API_KEY)
  // 3. A /models endpoint that returns { data: [{ id, name?, context_window?, max_tokens? }] }
  
  const providers = [
    {
      name: "ollama",
      baseUrl: "http://localhost:11434/v1",
      apiKeyEnv: "OLLAMA_API_KEY"
    },
    {
      name: "lm-studio",
      baseUrl: "http://localhost:1234/v1",
      apiKeyEnv: "LM_STUDIO_API_KEY"
    },
    {
      name: "vllm",
      baseUrl: "http://localhost:8000/v1",
      apiKeyEnv: "VLLM_API_KEY"
    },
    {
      name: "omega",
      baseUrl: "https://ai.n9.wtf/v1",
      apiKeyEnv: "OMEGA_API_KEY"
    },
    // Add more providers here as needed
  ];

  for (const provider of providers) {
    await discoverModels(pi, provider);
  }
}

async function discoverModels(
  pi: ExtensionAPI,
  provider: {
    name: string;
    baseUrl: string;
    apiKeyEnv: string;
  }
) {
  const { name, baseUrl, apiKeyEnv } = provider;

  // Check if API key is configured
  const apiKey = process.env[apiKeyEnv];
  if (!apiKey) {
    console.log(`${name}: ${apiKeyEnv} not set, skipping model discovery`);
    return;
  }

  try {
    console.log(`${name}: fetching models from ${baseUrl}/models...`);

    // Fetch models from the provider's /models endpoint
    const response = await fetch(`${baseUrl}/models`, {
      headers: {
        "Authorization": `Bearer ${apiKey}`,
        "Content-Type": "application/json"
      }
    });

    if (!response.ok) {
      console.warn(`${name}: failed to fetch models from ${baseUrl}/models: ${response.status} ${response.statusText}`);
      return;
    }

    const payload = (await response.json()) as {
      data: Array<{
        id: string;
        name?: string;
        context_window?: number;
        max_tokens?: number;
      }>;
    };

    if (!payload.data || payload.data.length === 0) {
      console.warn(`${name}: no models returned from ${baseUrl}/models`);
      return;
    }

    console.log(`${name}: discovered ${payload.data.length} models from ${baseUrl}`);

    // Convert discovered models to pi model format
    const discoveredModels = payload.data.map((model) => ({
      id: model.id,
      name: model.name ?? model.id,
      reasoning: false,
      input: ["text"] as const,
      cost: { input: 0, output: 0, cacheRead: 0, cacheWrite: 0 },
      contextWindow: model.context_window ?? 128000,
      maxTokens: model.max_tokens ?? 4096,
    }));

    // Register discovered models for this provider
    // This replaces any statically configured models for this provider
    pi.registerProvider(name, {
      baseUrl: baseUrl,
      apiKey: apiKeyEnv,
      api: "openai-completions" as const,
      models: discoveredModels,
      compat: {
        supportsDeveloperRole: false,
        supportsReasoningEffort: false
      }
    });

    console.log(`${name}: successfully registered ${discoveredModels.length} models`);
  } catch (error) {
    console.error(`${name}: error during model discovery: ${error instanceof Error ? error.message : String(error)}`);
  }
}
