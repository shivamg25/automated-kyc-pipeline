from google.cloud import storage

storage_client = storage.Client()

def get_gcs_metadata(bucket_name, file_name):
  bucket = storage_client.get_bucket(bucket_name)
  gcs_file = bucket.get_blob(file_name)
  if gcs_file is None:
    return None
  file_meta = gcs_file.metadata
  return file_meta
