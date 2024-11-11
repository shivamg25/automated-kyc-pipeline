from google.cloud import documentai
from config import PROJECT_ID, LOCATION, PROCESSOR_ID

def process_document_ai(file_name, bucket_name, mime_type):
    documentai_client = documentai.DocumentProcessorServiceClient()
    document_path = documentai_client.processor_path(PROJECT_ID, LOCATION, PROCESSOR_ID)
    gcs_uri = f"gs://{bucket_name}/{file_name}"
    gcs_document = documentai.GcsDocument(gcs_uri=gcs_uri, mime_type=mime_type)
    
    request = documentai.ProcessRequest(
        name=document_path,
        gcs_document=gcs_document
    )
    response = documentai_client.process_document(request=request)
    document = response.document
    
    max_confidence = 0.0
    highest_confidence_type = None
    for entity in document.entities:
        if entity.confidence > max_confidence:
            max_confidence = entity.confidence
            highest_confidence_type = entity.type_
    
    return highest_confidence_type, max_confidence
