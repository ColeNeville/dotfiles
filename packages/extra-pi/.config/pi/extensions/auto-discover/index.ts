import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";

/**
 * Extension for automatic model discovery from custom provider endpoints.
 * 
 * This extension fetches available models from the Omega provider's API endpoint
 * and registers them dynamically, ensuring the model list is always up-to-date
 * with the provider's API. It replaces any statically configured models.
 * 
 * Usage:
 * - Define the omega provider in models.json WITHOUT models (only baseUrl, apiKey, api)
 * - Set OMEGA_API_KEY environment variable or store in auth.json
 * - This extension will fetch and register all available models
 */
export default async function (pi: ExtensionAPI) {
  // Omega provider configuration
  const baseUrl = "https://ai.n9.wtf/v1";
  const apiKeyEnvVar = "OMEGA_API_KEY";
  
  // Verify API key is configured (check env var or auth.json)
  const apiKey = process.env[apiKeyEnvVar];
  if (!apiKey) {
    console.log(`OMEGA_API_KEY not set, skipping model discovery`);
    return;
  }

  try {
    // Fetch models from the provider's /models endpoint
    const response = await fetch(`${baseUrl}/models`, {
      headers: {
        "Authorization": `Bearer ${apiKey}`,
        "Content-Type": "application/json"
      }
    });
    
    if (!response.ok) {
      console.warn(`Failed to fetch models from ${baseUrl}/models: ${response.status} ${response.statusText}`);
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
      console.warn("No models returned from provider endpoint");
      return;
    }

    console.log(`Discovered ${payload.data.length} models from ${baseUrl}`);

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

    // Register discovered models for the omega provider
    // This replaces any statically configured models
    pi.registerProvider("omega", {
      baseUrl: baseUrl,
      apiKey: apiKeyEnvVar,
      api: "openai-completions" as const,
      models: discoveredModels,
      compat: {
        supportsDeveloperRole: false,
        supportsReasoningEffort: false
      }
    });

    console.log(`Successfully registered ${discoveredModels.length} models for omega provider`);
  } catch (error) {
    console.error(`Error during model discovery: ${error instanceof Error ? error.message : String(error)}`);
  }
}
