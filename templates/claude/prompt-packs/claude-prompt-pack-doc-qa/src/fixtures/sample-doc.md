# Sample Documentation — For Testing Doc Q&A Prompt Pack

> This is a fictional documentation file used only for smoke testing the Doc Q&A prompt pack.
> All values, endpoints, and configurations are invented for testing purposes.

## Overview

The **Acme Platform API** is a RESTful service for managing resources in the Acme cloud platform.
Base URL: `https://api.acme.example.com/v2`

## Authentication

All API calls require a Bearer token in the Authorization header:

```
Authorization: Bearer <access_token>
```

Tokens are obtained via the OAuth2 client credentials flow:

```bash
curl -X POST https://auth.acme.example.com/oauth/token \
  -d "grant_type=client_credentials" \
  -d "client_id=YOUR_CLIENT_ID" \
  -d "client_secret=YOUR_CLIENT_SECRET"
```

Tokens expire after **3600 seconds** (1 hour).

## Rate Limiting

| Tier | Requests/minute | Burst |
|------|----------------|-------|
| Free | 60 | 100 |
| Pro | 600 | 1000 |
| Enterprise | 6000 | unlimited |

Rate limit headers returned on every response:
- `X-RateLimit-Remaining`: requests left in current window
- `X-RateLimit-Reset`: Unix timestamp when the window resets

HTTP 429 is returned when the limit is exceeded.

## Endpoints

### Resources

**GET /v2/resources**
List all resources. Supports pagination.

Query params:
- `page` (int): Page number, default 1
- `per_page` (int): Items per page, default 20, max 100
- `status` (string): Filter by status. Values: `active`, `inactive`, `pending`

**POST /v2/resources**
Create a new resource. Requires scope `resources:write`.

Request body:
```json
{
  "name": "string (required, max 64 chars)",
  "type": "string (required, values: compute|storage|network)",
  "region": "string (required, values: us-east-1|eu-west-1|ap-southeast-1)",
  "tags": "object (optional)"
}
```

**DELETE /v2/resources/{id}**
Delete a resource. Requires scope `resources:delete`. Returns 204 on success.

## Error Codes

| Code | Meaning |
|------|---------|
| 400 | Bad request — validation error |
| 401 | Unauthorized — invalid or expired token |
| 403 | Forbidden — insufficient scope |
| 404 | Resource not found |
| 429 | Rate limit exceeded |
| 500 | Internal server error |

## Configuration Reference

### config.yml

```yaml
api:
  timeout_seconds: 30
  retry_max: 3
  retry_delay_ms: 500

logging:
  level: info  # debug | info | warn | error
  format: json  # json | text
  
cache:
  enabled: true
  ttl_seconds: 300
  max_size_mb: 128
```
