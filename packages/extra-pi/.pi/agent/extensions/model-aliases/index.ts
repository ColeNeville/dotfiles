/**
 * Model Alias Extension
 *
 * Reads per-model aliases from ~/.pi/agent/models.json and registers each
 * alias as a new model under the same provider. At request time, the alias
 * model ID is swapped to the parent model's ID so the API receives a
 * recognized model identifier.
 *
 * Config format (settings.json):
 * {
 *   "extensions": [ ... ],
 *   "logLevel": "warn" // "debug" | "info" | "warn" (default)
 * }
 *
 * Models.json format:
 * {
 *   "providers": {
 *     "omega-open-webui": {
 *       "baseUrl": "https://web.ai.n9.wtf/api/v1",
 *       "api": "openai-completions",
 *       "apiKey": "sk-...",
 *       "models": [
 *         {
 *           "id": "qwen36-35b-a3b-coder",
 *           "name": "Qwen3.6 35B A3B Coding",
 *           "contextWindow": 262144,
 *           "aliases": [
 *             { "id": "code", "name": "Coding" }
 *           ]
 *         }
 *       ]
 *     }
 *   }
 * }
 *
 * Auth: Inherited from the provider config automatically.
 * Hot-reload: Extension reads models.json once at factory time.
 * Changes require /reload.
 */

type LogLevel = "debug" | "info" | "warn";

const LOG_LEVEL_VALUES: Record<LogLevel, number> = {
	debug: 0,
	info: 1,
	warn: 2,
};

/** Minimum log level for a given log level string. Defaults to "warn". */
function getLogLevel(config: Record<string, unknown>): LogLevel {
	const raw = config.logLevel;
	if (typeof raw === "string" && raw in LOG_LEVEL_VALUES) {
		return raw as LogLevel;
	}
	return "warn";
}

/** Print a message only if its level meets the configured minimum. */
function log(level: LogLevel, message: string): void {
	if (LOG_LEVEL_VALUES[level] >= LOG_LEVEL_VALUES[currentLogLevel]) {
		console.log(`[model-aliases] ${message}`);
	}
}

let currentLogLevel: LogLevel = "warn";

/** Read settings.json and populate currentLogLevel. */
function readSettings(): void {
	const settingsJsonPath = join(getAgentDir(), "settings.json");
	if (!existsSync(settingsJsonPath)) {
		return;
	}
	try {
		const raw = readFileSync(settingsJsonPath, "utf-8");
		const settings = JSON.parse(raw);
		currentLogLevel = getLogLevel(settings);
	} catch {
		// Ignore parse errors — fall back to default
	}
}

// @ts-expect-error — pi provides these modules at runtime
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
// @ts-expect-error — pi provides these modules at runtime
import { existsSync, readFileSync } from "node:fs";
// @ts-expect-error — pi provides these modules at runtime
import { join } from "node:path";
// @ts-expect-error — pi provides these modules at runtime
import { getAgentDir } from "@earendil-works/pi-coding-agent";

// Map provider names to their built-in API type.
// Unknown providers default to openai-completions.
const PROVIDER_API_MAP: Record<string, string> = {
	openai: "openai-completions",
	anthropic: "anthropic-messages",
	google: "google-generative-ai",
	openrouter: "openai-completions",
	deepseek: "openai-completions",
	xai: "openai-completions",
	azure: "azure-openai-responses",
	bedrock: "bedrock-converse-stream",
	mistral: "mistral-conversations",
	zai: "openai-completions",
	fireworks: "openai-completions",
	groq: "openai-completions",
	cerebras: "openai-completions",
	minimax: "openai-completions",
	moonshotai: "openai-completions",
	huggingface: "openai-completions",
	opencode: "openai-completions",
	"vercel-ai-gateway": "openai-completions",
};

/**
 * Resolves the API type for a provider name.
 * Falls back to openai-completions if unknown.
 */
function resolveApiType(providerName: string): string {
	return PROVIDER_API_MAP[providerName] ?? "openai-completions";
}

/**
 * Builds a model object from a parent model entry with full metadata.
 */
function buildModelEntry(
	parentEntry: Record<string, unknown>,
	alias: { id: string; name: string },
): Record<string, unknown> {
	const ctxWindow = parentEntry.contextWindow as number | undefined;
	const maxTok = parentEntry.maxTokens as number | undefined;

	// Apply alias-level overrides
	const overrideKeys = [
		"reasoning",
		"input",
		"contextWindow",
		"maxTokens",
		"cost",
		"thinkingLevelMap",
		"compat",
	];
	const overrides: Record<string, unknown> = {};
	for (const key of overrideKeys) {
		if (key in alias) {
			overrides[key] = (alias as Record<string, unknown>)[key];
		}
	}

	return {
		id: alias.id,
		name: alias.name,
		reasoning: Boolean(parentEntry.reasoning),
		input: Array.isArray(parentEntry.input) ? parentEntry.input : ["text"],
		contextWindow: ctxWindow ?? 128000,
		maxTokens: maxTok ?? 16384,
		cost:
			typeof parentEntry.cost === "object" && parentEntry.cost !== null
				? (parentEntry.cost as Record<string, unknown>)
				: { input: 0, output: 0, cacheRead: 0, cacheWrite: 0 },
		...overrides,
	};
}

/**
 * Builds a clean copy of all original models with required field defaults.
 */
function buildOriginalModels(
	originalModels: Array<Record<string, unknown>>,
): Record<string, unknown>[] {
	const result: Record<string, unknown>[] = [];
	for (const m of originalModels) {
		log(
			"debug",
			`original model: ${m.id} input=${JSON.stringify(m.input)} reasoning=${m.reasoning} keys=${Object.keys(m)}`,
		);
		result.push({
			id: m.id,
			name: m.name,
			input: Array.isArray(m.input) ? m.input : ["text"],
			reasoning: Boolean(m.reasoning),
			contextWindow: m.contextWindow ?? 128000,
			maxTokens: m.maxTokens ?? 16384,
			cost:
				typeof m.cost === "object" && m.cost !== null
					? (m.cost as Record<string, unknown>)
					: { input: 0, output: 0, cacheRead: 0, cacheWrite: 0 },
		});
	}
	return result;
}

/**
 * Registers a provider with all original models and aliases.
 */
function registerProviderWithModels(
	pi: ExtensionAPI,
	providerName: string,
	providerConfig: Record<string, unknown>,
	api: string,
	baseUrl: string,
	apiKey: string,
	aliasedModels: Record<string, unknown>[],
): void {
	pi.unregisterProvider(providerName);
	pi.registerProvider(providerName, {
		name: providerConfig.name ?? providerName,
		baseUrl,
		apiKey,
		api,
		models: aliasedModels,
	});
}

/**
 * Main extension factory.
 * Reads models.json, finds models with aliases, registers each alias
 * as a new model under the same provider, and sets up request-time
 * model ID swapping via the before_provider_request event.
 */
export default async function (pi: ExtensionAPI) {
	// Read log level from settings.json
	readSettings();

	const modelsJsonPath = join(getAgentDir(), "models.json");

	if (!existsSync(modelsJsonPath)) {
		return;
	}

	let config: Record<string, unknown>;
	try {
		const raw = readFileSync(modelsJsonPath, "utf-8");
		config = JSON.parse(raw);
	} catch (err) {
		console.warn(
			`[model-aliases] Failed to parse models.json: ${err instanceof Error ? err.message : String(err)}`,
		);
		return;
	}

	const providers = config.providers as
		| Record<string, Record<string, unknown>>
		| undefined;

	if (!providers || typeof providers !== "object") {
		return;
	}

	// Alias-to-parent mapping: aliasId → parentId
	const aliasMap = new Map<string, string>();

	// In-memory cache: parentId → full parent model config
	// Loaded lazily on first request to an alias
	const parentCache = new Map<string, Record<string, unknown>>();

	// Capture models.json for lazy cache loading
	const modelsJsonRaw = readFileSync(modelsJsonPath, "utf-8");

	// Set up before_provider_request handler to swap model IDs at request time
	pi.on("before_provider_request", (event) => {
		const modelId = event.payload.model as string | undefined;
		if (!modelId) {
			return event.payload;
		}

		const parentId = aliasMap.get(modelId);
		if (!parentId) {
			return event.payload;
		}

		// Lazy-load cache on first request
		if (!parentCache.has(parentId)) {
			try {
				const parsed = JSON.parse(modelsJsonRaw);
				const providerConfigs = parsed.providers as Record<
					string,
					Record<string, unknown>
				>;
				if (providerConfigs) {
					for (const providerConfig of Object.values(providerConfigs)) {
						const models = providerConfig.models as
							| Array<Record<string, unknown>>
							| undefined;
						if (Array.isArray(models)) {
							for (const m of models) {
								if (m.id === parentId) {
									parentCache.set(parentId, m);
									break;
								}
							}
						}
					}
				}
			} catch {
				// Ignore parse errors — fall back to original model ID
			}
		}

		const parent = parentCache.get(parentId);
		if (parent) {
			event.payload.model = parent.id;
			log("debug", `Swapped "${modelId}" → "${parent.id}"`);
			return event.payload;
		}

		return event.payload;
	});

	// Collect all aliases per provider before registering.
	// This ensures we register each provider only once with ALL aliases.
	// The original code registered per-model, which overwrote previous
	// registrations — only the last model's aliases survived.
	interface ProviderAliasEntry {
		providerName: string;
		providerConfig: Record<string, unknown>;
		modelEntry: Record<string, unknown>;
		aliasList: Array<{ id: string; name: string }>;
	}

	const allEntries: ProviderAliasEntry[] = [];

	for (const [providerName, providerConfig] of Object.entries(providers)) {
		const models = providerConfig.models as
			| Array<Record<string, unknown>>
			| undefined;
		if (!Array.isArray(models)) {
			continue;
		}

		for (const model of models) {
			const aliasList = model.aliases as
				| Array<{ id: string; name: string }>
				| undefined;
			if (!aliasList || !Array.isArray(aliasList) || aliasList.length === 0) {
				continue;
			}

			// Build alias-to-parent mapping
			for (const alias of aliasList) {
				aliasMap.set(alias.id, model.id as string);
			}

			allEntries.push({
				providerName,
				providerConfig: providerConfig as Record<string, unknown>,
				modelEntry: model as Record<string, unknown>,
				aliasList,
			});
		}
	}

	// Group entries by provider
	const providerEntries = new Map<string, ProviderAliasEntry[]>();
	for (const entry of allEntries) {
		const existing = providerEntries.get(entry.providerName) ?? [];
		existing.push(entry);
		providerEntries.set(entry.providerName, existing);
	}

	// Register each provider once with all aliases
	let totalRegistered = 0;

	for (const [providerName, entries] of providerEntries) {
		const providerConfig = entries[0].providerConfig;
		const api = resolveApiType(providerName);
		const baseUrl = providerConfig.baseUrl as string | undefined;
		const apiKey = providerConfig.apiKey as string | undefined;

		if (!baseUrl) {
			console.warn(
				`[model-aliases] Skipping "${providerName}": provider has no baseUrl`,
			);
			continue;
		}

		if (!apiKey) {
			console.warn(
				`[model-aliases] Skipping "${providerName}": provider has no apiKey (OAuth targets not supported)`,
			);
			continue;
		}

		// Build clean copies of all original models (once per provider)
		const originalModels = providerConfig.models as
			| Array<Record<string, unknown>>
			| undefined;
		const aliasedModels = originalModels
			? buildOriginalModels(originalModels)
			: [];

		// Add all alias models
		for (const entry of entries) {
			for (const alias of entry.aliasList) {
				const aliasModel = buildModelEntry(entry.modelEntry, alias);
				aliasedModels.push(aliasModel);
				log(
					"info",
					`Registered "${alias.id}" → ${providerName}/${entry.modelEntry.id}`,
				);
				totalRegistered++;
			}
		}

		// Register provider once with all models + aliases
		registerProviderWithModels(
			pi,
			providerName,
			providerConfig,
			api,
			baseUrl,
			apiKey,
			aliasedModels,
		);
	}

	if (totalRegistered > 0) {
		log("info", `Registered ${totalRegistered} alias(es)`);
	}
}
