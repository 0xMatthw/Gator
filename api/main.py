#!/usr/bin/env python3
"""
Vercel entrypoint for Gator OSINT API
Re-exports the FastAPI app from backend_api.py
"""

from backend_api import app

# Vercel looks for 'app' in this file
# We're just importing it from backend_api.py where it's actually defined
