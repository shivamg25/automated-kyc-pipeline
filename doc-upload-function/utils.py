import os

def get_cors_headers(is_preflight=False):
    headers = {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers": "Content-Type"
    }
    if is_preflight:
        headers.update({
            "Access-Control-Allow-Methods": "POST",
            "Access-Control-Max-Age": "3600"
        })
    return headers

def extract_file_extension(filename):
    return os.path.splitext(filename)[1].lower()
