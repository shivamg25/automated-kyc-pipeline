import os
import uuid

# Configuration and constants
bucket_name = os.environ["BUCKET_NAME"]
submission_id = str(uuid.uuid4())

# MIME types mapping
mime_types = {
    '.pdf': 'application/pdf',
    '.gif': 'image/gif',
    '.tiff': 'image/tiff',
    '.tif': 'image/tiff',
    '.jpg': 'image/jpeg',
    '.jpeg': 'image/jpeg',
    '.png': 'image/png',
    '.bmp': 'image/bmp',
    '.webp': 'image/webp'
}
