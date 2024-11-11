from google.cloud import storage
from config import DESTINATION_BUCKET
from config import logger

def get_file_details(event):
    bucket_name = event['bucket']
    file_name = event['name']
    storage_client = storage.Client()
    bucket = storage_client.get_bucket(bucket_name)
    gcs_file = bucket.get_blob(file_name)
    if gcs_file is None:
        return None, None, None
    
    file_meta = gcs_file.metadata
    submission_id = file_meta['submission_id']
    mime_type = file_meta['mime_type']
    
    return gcs_file, bucket_name, file_name, mime_type

def move_file_to_bucket(gcs_file, bucket_name, file_name):
    storage_client = storage.Client()
    source_bucket = storage_client.bucket(bucket_name)
    destination_bucket = storage_client.bucket(DESTINATION_BUCKET)
    blob_copy = source_bucket.copy_blob(source_bucket.blob(file_name), destination_bucket, file_name)
    gcs_file.delete()
    logger.info(f"File moved to {DESTINATION_BUCKET} and deleted from the original bucket.")
