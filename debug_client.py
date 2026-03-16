import os
import sys
import traceback

print(f"Python: {sys.executable}")
try:
    import httpx
    print(f"httpx version: {httpx.__version__}")
except ImportError:
    print("httpx missing")

try:
    import anthropic
    print(f"anthropic version: {anthropic.__version__}")
except ImportError:
    print("anthropic missing")

print("-" * 20)
print("Attempting to initialize Anthropic client...")

try:
    client = anthropic.Anthropic(api_key="sk-dummy-key")
    print("SUCCESS: Client initialized.")
except Exception as e:
    print(f"FAILURE: {e}")
    traceback.print_exc()
