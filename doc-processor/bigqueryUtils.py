from google.cloud import bigquery
import logging

def upload_to_bigquery(data, dataset_id, table_id):
    client = bigquery.Client()
    table_ref = client.dataset(dataset_id).table(table_id)
    table = client.get_table(table_ref)  # Ensure the table exists.

    errors = client.insert_rows_json(table, [data])  # Make API request to insert data
    if errors:
        logging.error(f"Failed to upload data to BigQuery: {errors}")
        raise ValueError(f"Failed to upload data to BigQuery: {errors}")

def prepare_bigquery_data(entities, document_metadata):
    """Prepare data for BigQuery based on the extracted entities and document metadata."""
    data = {
        'SubmissionId': document_metadata.get('submission_id', ''),
        'MimeType': document_metadata.get('mime_type', ''),
        'DocumentType': document_metadata.get('document_type', ''),
        'IdentityNumber': entities.get('IDNumber', ''),
        'Name': entities.get('Name', ''),
        'DateOfBirth': entities.get('DateOfBirth', ''),
        'Gender': entities.get('Gender', ''),
        'FatherName': entities.get('FatherName', ''),
        'MotherName': entities.get('MotherName', ''),
        'Address': entities.get('Address', '')
    }
    return data
