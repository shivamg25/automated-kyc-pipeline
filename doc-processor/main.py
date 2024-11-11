import logging
import os
from google.cloud.functions.context import Context
from document_processor import create_documentai_client, process_document
from storageUtils import get_gcs_metadata
from bigqueryUtils import prepare_bigquery_data, upload_to_bigquery

# Setup basic logging
logging.basicConfig(level=logging.INFO)

# Constants
PROJECT_ID = os.environ["PROJECT_ID"]
LOCATION = os.environ["LOCATION"]
PROCESSOR_ID = os.environ["PROCESSOR_ID"]
DATASET_ID = os.environ["DATASET_ID"]
TABLE_ID = os.environ["TABLE_ID"]
FIELD_MASK = "text,entities,pages"

def process_document_trigger(event, context: Context):
  """Cloud Function to be triggered by Cloud Storage.
     This function processes files uploaded to Google Cloud Storage with Document AI.
  """
  # Get file details from the event
  BUCKET_NAME = event['bucket']
  FILE_NAME = event['name']
  file_meta = get_gcs_metadata(BUCKET_NAME, FILE_NAME)
    
  # Extract metadata 
  SUBMISSION_ID = file_meta['submission_id']
  MIME_TYPE = file_meta['mime_type']
  DOCUMENT_TYPE = file_meta["document_type"]

  client = create_documentai_client(LOCATION)
  results = process_document(client, PROJECT_ID, LOCATION, PROCESSOR_ID, MIME_TYPE, DOCUMENT_TYPE, BUCKET_NAME, FILE_NAME, FIELD_MASK)

  # Prepare data for BigQuery
  document_metadata = {
      'submission_id': SUBMISSION_ID,
      'mime_type': MIME_TYPE,
      'document_type': DOCUMENT_TYPE
  }
  # Assume `results` is a dictionary with the necessary keys
  if results:
      bq_data = prepare_bigquery_data(results, document_metadata)
      # Define your dataset_id and table_id for BigQuery
      dataset_id = DATASET_ID
      table_id = TABLE_ID
      try:
         upload_to_bigquery(bq_data, dataset_id, table_id)
         logging.info("Data successfully uploaded to BigQuery.")
      except Exception as e:
         logging.error(f"Failed to upload data to BigQuery: {e}")
  else:
      logging.error("No results to upload to BigQuery.")
  print(results)
