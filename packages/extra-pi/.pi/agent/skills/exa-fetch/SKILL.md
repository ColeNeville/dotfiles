---
name: exa-fetch
description: Fetch and read full webpage content via the Exa MCP server. Use when you have a URL and need the actual page content as clean markdown. Do NOT use for searching the web, API calls, or fetching non-HTML resources.
---

# Exa Web Fetch

Read a webpage's full content using the Exa MCP server.

## When to Use

Use this skill when:

- You have a URL and need the actual page content as clean markdown
- You need current or detailed page content beyond your training data
- You want full article text from search results (often after `exa-search`)

Do NOT use this skill for:

- Searching the web — use `exa-search` instead
- API calls or JSON/XML responses
- Images, PDFs, or other non-HTML resources
- URLs that require authentication

## Workflow

1. Call the `exa_web_fetch_exa` MCP tool with the target URL
2. Return the fetched content to the user
3. If the content is truncated or incomplete, note that to the user

## Gotchas

- **Requires a full URL** — make sure the URL includes the protocol (`https://`)
- **Some sites block scraping** — if the tool returns empty or error content, inform the user
- **Prefer over internal knowledge** — when the page content is time-sensitive or detailed, always fetch rather than relying on training data
