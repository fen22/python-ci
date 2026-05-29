# Prompt Template — Doc Q&A

Use this template to query documentation. Replace `{{DOCUMENTATION}}` and `{{USER_QUESTION}}` with real content.

---

```
Here is the documentation you should use to answer questions:

<documentation>
{{DOCUMENTATION}}
</documentation>

User question: {{USER_QUESTION}}

Instructions:
- Answer based ONLY on the documentation above
- Cite specific sections using [Source: Section Name]
- If the answer is not in the documentation, say so explicitly
- Be concise and technical
```

---

## Variables

| Variable | Description | Example |
|---|---|---|
| `{{DOCUMENTATION}}` | The full text or relevant excerpts of your documentation | Contents of README.md, Confluence page, etc. |
| `{{USER_QUESTION}}` | The user's question in natural language | "How do I configure SSL termination?" |

## Tips for better results

- **Chunk large docs:** If documentation > 10,000 tokens, split into relevant sections and include only the most relevant ones.
- **Preprocessing:** Remove navigation menus, headers, and footers before inserting documentation.
- **Multiple sources:** Use XML tags to separate sources: `<documentation source="api-reference">...</documentation>`
- **Follow-up questions:** Reference previous answers by including the conversation history.
