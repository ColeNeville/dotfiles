import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";
import * as fs from "fs";
import * as path from "path";

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
 * - The extension will automatically discover and register models for each provider
 * - API keys can be set via environment variables or as literals in models.json
 */
export default async function (pi: ExtensionAPI) {
  // Find models.json - check both XDG_CONFIG_HOME and default location
  const modelsJsonPath = findModelsJson();
  
  if (!modelsJsonPath) {
    console.log("models.json not found, skipping model discovery");
    return;
  }

  console.log(`Reading models.json from: ${modelsJsonPath}`);

  try {
    const content = fs.readFileSync(modelsJsonPath, "utf-8");
    const parsed = JSON.parse(content) as {
      providers?: Record<string, {
        baseUrl?: string;
        apiKey?: string;
        api?: string;
        compat?: any;
      }>;
    };

    if (!parsed.providers) {
      console.log("No providers defined in models.json, skipping model discovery");
      return;
    }

    // Get all provider names from models.json
    const providerNames = Object.keys(parsed.providers);

    console.log(`Found ${providerNames.length} provider(s) in models.json: ${providerNames.join(", ")}`);

    // Process each provider
    for (const providerName of providerNames) {
      const providerConfig = parsed.providers[providerName];
      
      if (!providerConfig.baseUrl) {
        console.log(`${providerName}: no baseUrl configured, skipping`);
        continue;
      }

      await discoverModels(pi, providerName, providerConfig);
    }
  } catch (error) {
    console.error(`Error reading models.json: ${error instanceof Error ? error.message : String(error)}`);
  }
}

function findModelsJson(): string | null {
  // Check XDG_CONFIG_HOME first
  if (process.env.XDG_CONFIG_HOME) {
    const xdgPath = path.join(process.env.XDG_CONFIG_HOME, "pi", "models.json");
    if (fs.existsSync(xdgPath)) {
      return xdgPath;
    }
  }

  // Check default location
  const defaultPath = path.join(process.env.HOME || "", ".config", "pi", "models.json");
  if (fs.existsSync(defaultPath)) {
    return defaultPath;
  }

  return null;
}

async function discoverModels(
  pi: ExtensionAPI,
  providerName: string,
  providerConfig: {
    baseUrl: string;
    apiKey?: string;
    api?: string;
    compat?: any;
  }
) {
  const { baseUrl, apiKey, api, compat } = providerConfig;

  // Resolve the API key
  const resolvedApiKey = await resolveApiKey(apiKey);
  
  if (!resolvedApiKey) {
    console.log(`${providerName}: no API key configured, skipping model discovery`);
    return;
  }

  try {
    console.log(`${providerName}: fetching models from ${baseUrl}/models...`);

    // Fetch models from the provider's /models endpoint
    const response = await fetch(`${baseUrl}/models`, {
      headers: {
        "Authorization": `Bearer ${resolvedApiKey}`,
        "Content-Type": "application/json"
      }
    });

    if (!response.ok) {
      console.warn(`${providerName}: failed to fetch models from ${baseUrl}/models: ${response.status} ${response.statusText}`);
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
      console.warn(`${providerName}: no models returned from ${baseUrl}/models`);
      return;
    }

    console.log(`${providerName}: discovered ${payload.data.length} models from ${baseUrl}`);

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
    pi.registerProvider(providerName, {
      baseUrl: baseUrl,
      apiKey: apiKey,
      api: (api as any) || "openai-completions",
      models: discoveredModels,
      compat: compat
    });

    console.log(`${providerName}: successfully registered ${discoveredModels.length} models`);
  } catch (error) {
    console.error(`${providerName}: error during model discovery: ${error instanceof Error ? error.message : String(error)}`);
  }
}

/**
 * Resolve an API key from models.json configuration.
 * Supports:
 * - Environment variable name (e.g., "MY_API_KEY")
 * - Shell command (e.g., "!command")
 * - Literal value
 */
async function resolveApiKey(apiKey?: string): Promise<string | null> {
  if (!apiKey) {
    return null;
  }

  // Shell command - execute it
  if (apiKey.startsWith("!")) {
    const command = apiKey.slice(1);
    try {
      const { exec } = await import("node:child_process");
      const util = await import("node:util");
      const execPromise = util.promisify(exec);
      const { stdout } = await execPromise(command, { maxBuffer: 1024 * 1024 });
      return stdout.trim();
    } catch (error) {
      console.error(`Failed to execute API key command: ${error instanceof Error ? error.message : String(error)}`);
      return null;
    }
  }

  // Environment variable
  const envValue = process.env[apiKey];
  if (envValue) {
    return envValue;
  }

  // Literal value
  return apiKey;
}
