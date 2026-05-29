# Examples — Doc Q&A Prompt Pack

## Example 1: API Documentation Query

**Documentation provided:**
```
## Authentication

The API uses Bearer token authentication. Include the token in the Authorization header:

Authorization: Bearer <your-token>

Tokens expire after 24 hours. Use the /auth/refresh endpoint to renew.

### Rate Limiting
All endpoints are rate limited to 1000 requests/hour per API key.
Exceeding the limit returns HTTP 429.

### Endpoints

POST /v1/users - Create user
GET  /v1/users/{id} - Get user by ID
DELETE /v1/users/{id} - Delete user (requires admin scope)
```

**User question:** `How do I authenticate and what happens if I exceed rate limits?`

**Expected Claude response:**
```
**Answer:** Use Bearer token authentication in the Authorization header, and if you exceed 1,000 requests/hour you'll receive an HTTP 429 response.

**Details:**
Include your token in every request:
`Authorization: Bearer <your-token>`

Tokens are valid for 24 hours. Renew with `/auth/refresh`. [Source: Authentication]

If you hit the 1,000 requests/hour limit, the API returns HTTP 429. The documentation does not specify a retry-after header or backoff strategy. [Source: Rate Limiting]

**Sources:** Authentication, Rate Limiting sections

**Note:** The documentation doesn't cover how to obtain an initial token or whether different scopes have different rate limits.
```

---

## Example 2: Configuration Documentation Query

**Documentation provided:**
```
## Configuration Reference

### database.yml

host: (string) Database hostname. Default: localhost
port: (integer) Database port. Default: 5432
pool_size: (integer) Connection pool size. Default: 10. Max: 50
ssl_mode: (string) SSL mode. Values: disable, allow, require. Default: require
timeout_ms: (integer) Query timeout in milliseconds. Default: 30000
```

**User question:** `What's the maximum connection pool size and what SSL modes are available?`

**Expected Claude response:**
```
**Answer:** The maximum connection pool size is 50, and the available SSL modes are: disable, allow, and require.

**Details:**
- `pool_size`: Integer, maximum value 50 (default: 10) [Source: database.yml reference]
- `ssl_mode`: Accepts three values — `disable`, `allow`, `require`. Default is `require` [Source: database.yml reference]

**Sources:** Configuration Reference → database.yml

**Note:** The documentation doesn't explain the behavioral differences between `allow` and `require` SSL modes.
```

---

## Example 3: "Not in Documentation" Response

**Documentation provided:**
```
## Deployment

Deploy using Docker:
docker run -p 8080:8080 myapp:latest

## Monitoring

Check application health at: GET /health
```

**User question:** `How do I set up Kubernetes autoscaling for this service?`

**Expected Claude response:**
```
**Answer:** This topic is not covered in the provided documentation.

**Details:**
The documentation only covers Docker deployment (`docker run`) and a health check endpoint (`GET /health`). [Source: Deployment, Monitoring sections]

Kubernetes autoscaling configuration is not mentioned.

**Sources:** Deployment, Monitoring

**Note:** For Kubernetes setup, check the infrastructure repository, your DevOps team's runbooks, or the official Kubernetes HorizontalPodAutoscaler documentation.
```
