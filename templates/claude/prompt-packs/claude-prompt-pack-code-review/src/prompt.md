# Prompt Templates — Code Review

## Template A: Review completo de un archivo

```
Please review the following {{LANGUAGE}} code:

**Context:** {{CONTEXT}}
**PR description:** {{PR_DESCRIPTION}}

```{{LANGUAGE}}
{{CODE}}
```

Perform a thorough review covering correctness, security, performance, readability, and best practices.
```

## Template B: Review enfocado en seguridad

```
Security review for the following {{LANGUAGE}} code.

Focus exclusively on:
- Authentication and authorization issues
- Input validation and sanitization
- SQL/command injection risks
- Exposed credentials or sensitive data
- Insecure dependencies or imports
- OWASP Top 10 vulnerabilities

Code:
```{{LANGUAGE}}
{{CODE}}
```
```

## Template C: Review de PR diff

```
Review the following git diff for a pull request.

**PR Title:** {{PR_TITLE}}
**Branch:** {{BRANCH}} → main
**Description:** {{PR_DESCRIPTION}}

```diff
{{DIFF}}
```

Focus on:
1. Does the implementation match the PR description?
2. Are there any unintended side effects?
3. What's missing (tests, error handling, docs)?
```

## Variables

| Variable | Description |
|---|---|
| `{{LANGUAGE}}` | Programming language (Python, TypeScript, Go, etc.) |
| `{{CODE}}` | The code to review |
| `{{CONTEXT}}` | What the code does, why it was written |
| `{{PR_DESCRIPTION}}` | The PR description / ticket context |
| `{{PR_TITLE}}` | PR title |
| `{{BRANCH}}` | Feature branch name |
| `{{DIFF}}` | Git diff output |
