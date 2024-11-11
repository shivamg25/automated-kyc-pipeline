import json
import logging
from google.api_core.client_options import ClientOptions
from google.cloud import documentai
from utils import clean_value, extract_english_name

def process_document(client, project_id, location, processor_id, mime_type, document_type, bucket_name, file_name, field_mask=None):
    """ Processes the document using Document AI. """
    try:
        name = client.processor_path(project_id, location, processor_id)
        gcs_uri = f"gs://{bucket_name}/{file_name}"
        gcs_document = documentai.GcsDocument(gcs_uri=gcs_uri, mime_type=mime_type)
        request = documentai.ProcessRequest(name=name, gcs_document=gcs_document, field_mask=field_mask)

        response = client.process_document(request=request)
        return extract_entities(response.document, document_type)
    except Exception as e:
        logging.error(f"Failed to process document: {e}")
        return {}

def extract_entities(document, document_type):
    """ Extracts and cleans entities from the document. """
    extracted_entities = {}
    first_name = ""
    last_name = ""

    for entity in document.entities:
        entity_type = entity.type_
        entity_value = entity.normalized_value.text.strip() if entity.normalized_value else entity.mention_text.strip()
        entity_value = clean_value(entity_value, entity_type) if entity_type != "Name" else extract_english_name(entity.mention_text)

        if document_type == "Passport" and entity_type in ["FirstName", "LastName"]:
            if entity_type == "FirstName":
                first_name = entity_value
            elif entity_type == "LastName":
                last_name = entity_value
        else:
            if entity_type not in extracted_entities:
                extracted_entities[entity_type] = set() if entity_type in ["Passport_Number", "Aadhaar_Number", "PAN_Number", "VoterID_Number"] else []
            extracted_entities[entity_type].add(entity_value) if isinstance(extracted_entities[entity_type], set) else extracted_entities[entity_type].append(entity_value)

    if document_type == "Passport" and first_name and last_name:
        combined_name = f"{first_name} {last_name}"
        if "Name" in extracted_entities:
            extracted_entities["Name"].append(combined_name)
        else:
            extracted_entities["Name"] = [combined_name]

    for key in extracted_entities:
        if isinstance(extracted_entities[key], set):
            extracted_entities[key] = list(extracted_entities[key])

    return json.dumps(extracted_entities, indent=2)

def create_documentai_client(location):
    """ Creates a Document AI client configured for the specified location. """
    opts = ClientOptions(api_endpoint=f"{location}-documentai.googleapis.com")
    return documentai.DocumentProcessorServiceClient(client_options=opts)
