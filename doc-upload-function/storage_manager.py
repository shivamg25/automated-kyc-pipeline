from google.cloud import storage
from config import bucket_name, submission_id, mime_types
from utils import extract_file_extension


def upload_file_to_storage(file, filename):
    mime_type = mime_types.get(extract_file_extension(filename), 'application/octet-stream')
    storage_client = storage.Client()
    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(filename)
    metadata = {
        "submission_id": submission_id,
        "mime_type": mime_type
    }
    blob.metadata = metadata
    blob.upload_from_file(file)
    return "File uploaded successfully"
