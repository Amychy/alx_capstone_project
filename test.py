import secrets

# Generate a secure secret key
secret_key = secrets.token_hex(16)  # 16 bytes (128 bits) provides a strong key
print(secret_key)
