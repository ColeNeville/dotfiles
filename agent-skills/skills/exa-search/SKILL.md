---
name: exa-search
description: Web search via the Exa MCP server. Use when the user asks to search the web, look up current information, find recent news, or retrieve anything beyond your training data. Do NOT use for database queries, API calls, or text formatting tasks.
---

# Exa Web Search

Search the web using the Exa MCP server.

## When to Use

Use this skill whenever the user asks to:

- Search the web or look up information
- Find current or recent news
- Retrieve anything beyond your training data cutoff
- Search for topics with "search", "look up", "find online", "get the latest"

Do NOT use this skill for:

- Database queries or API calls
- Text formatting, summarization, or translation
- Questions answerable from your training data

## Workflow

1. Call the `exa_web_search_exa` MCP tool with a specific, focused query string
2. If results are too broad, refine the query and search again
3. For detailed articles, follow up with the `exa-fetch` skill to read full page content

## Gotchas

- **Vague queries return noisy results** — narrow the query with dates, sources, or specific terms
- **Don't over-search** — if the first results answer the question, stop; don't re-run the same query
- **This is for web search only** — for fetching full page content from a known URL, use `exa-fetch` instead
