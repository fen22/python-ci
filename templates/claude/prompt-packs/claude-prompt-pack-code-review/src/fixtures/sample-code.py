# Sample code for testing the Code Review prompt pack
# This file intentionally contains several issues for review

import os
import sqlite3

SECRET_KEY = "hardcoded-secret-key-123"  # Issue: hardcoded secret

def get_user(user_id):
    conn = sqlite3.connect("users.db")
    query = f"SELECT * FROM users WHERE id = {user_id}"  # Issue: SQL injection
    result = conn.execute(query).fetchall()
    conn.close()
    return result

def process_items(items):
    results = []
    for item in items:
        # Issue: N+1 query pattern
        details = get_user(item["user_id"])
        results.append(details)
    return results

def divide(a, b):
    return a / b  # Issue: no zero division check

def save_file(filename, content):
    # Issue: no path traversal protection
    with open(f"/data/{filename}", "w") as f:
        f.write(content)
