from google.cloud.functions.context import Context
from storage_manager import get_file_details, move_file_to_bucket
from document_processor import process_document_ai
from config import logger

def process_document_trigger(event, context: Context):
    """Cloud Function to be triggered by Cloud Storage.
       This function processes files uploaded to Google Cloud Storage with Document AI.
    """
    gcs_file, bucket_name, file_name, mime_type = get_file_details(event)
    if not gcs_file:
        return None
    
    highest_confidence_type, max_confidence = process_document_ai(file_name, bucket_name, mime_type)
    
    if highest_confidence_type:
        logger.info(f"Document processed with high confidence: {highest_confidence_type} (Confidence: {max_confidence})")
        
        try:
            gcs_file.metadata = {"document_type": highest_confidence_type}
            gcs_file.patch()
            move_file_to_bucket(gcs_file, bucket_name, file_name)
        except Exception as e:
            logger.error(f"Failed to update metadata: {e}")
    else:
        logger.info("No high confidence document type found.")
