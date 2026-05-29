# Examples — Code Review Prompt Pack

## Example 1: Python API endpoint with security issues

**Input:**
```python
@app.route('/user')
def get_user():
    user_id = request.args.get('id')
    query = f"SELECT * FROM users WHERE id = {user_id}"
    result = db.execute(query)
    return jsonify(result)
```

**Expected Claude response:**
```
**[CRITICAL]** `app.py:4` — SQL Injection vulnerability
- *Why:* `user_id` is inserted directly into the query string. An attacker can pass `1; DROP TABLE users` to destroy data, or `1 OR 1=1` to leak all users.
- *Fix:* Use parameterized queries: `db.execute("SELECT * FROM users WHERE id = ?", (user_id,))`

**[HIGH]** `app.py:2` — No input validation on `user_id`
- *Why:* No check that `id` is present or is a valid integer. Passing no ID or a non-integer crashes the query.
- *Fix:* `user_id = request.args.get('id'); if not user_id or not user_id.isdigit(): abort(400)`

**[HIGH]** `app.py:5` — Returning full user object to client
- *Why:* `SELECT *` may include password hashes, tokens, or PII that should not be exposed via API.
- *Fix:* Explicitly select only the fields needed: `SELECT id, name, email FROM users WHERE id = ?`

**[MEDIUM]** `app.py:1` — No authentication on this endpoint
- *Why:* Any unauthenticated user can query any user's data.
- *Fix:* Add `@login_required` decorator or equivalent auth middleware.

**Summary:** 1 CRITICAL, 2 HIGH, 1 MEDIUM
**Assessment: REQUEST CHANGES** — Critical SQL injection must be fixed before merge.
```

---

## Example 2: Clean TypeScript function (LGTM)

**Input:**
```typescript
async function fetchUserById(userId: string): Promise<User | null> {
  if (!userId || typeof userId !== 'string') {
    throw new Error('Invalid userId');
  }
  try {
    const user = await db.users.findUnique({ where: { id: userId } });
    return user;
  } catch (error) {
    logger.error('Failed to fetch user', { userId, error });
    throw new DatabaseError('User lookup failed');
  }
}
```

**Expected Claude response:**
```
**[INFO]** Good use of input validation, typed return, structured error handling, and logging.

**Summary:** 0 issues found
**Assessment: APPROVE** ✅ — LGTM. The function correctly validates input, handles null returns, logs errors with context, and wraps DB errors in a domain-specific error class.

**Top improvement (optional):**
- Consider adding a timeout to the DB call if `findUnique` can hang on slow connections.
```
