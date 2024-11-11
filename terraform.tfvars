sa = [
  {
    account_id    = "thesis-poc-on-automated-kyc-sa"
    display_name  = "ThesisServiceAccount"
    project_id    = "thesis-poc-on-automated-kyc"
    create_sa_key = false
    description   = "Thesis POC SA"
  }
]

bq_dataset = [
  {
    dataset_id   = "IdentityDocumentsDataset"
    dataset_name = "IdentityDocumentsDataset"
    description  = "Automated KYC Dataset"
    location     = "US"
    project_id   = "thesis-poc-on-automated-kyc"
    role_bind_dataset = [
      {
        role    = "roles/bigquery.dataOwner"
        members = ["serviceAccount:thesis-poc-on-automated-kyc-sa@thesis-poc-on-automated-kyc.iam.gserviceaccount.com"]
      }
    ]
  }
]

bq_table = [
  {
    table_id            = "ExtractedData"
    deletion_protection = true
    project_id          = "thesis-poc-on-automated-kyc"
    role_bind_table = [
      {
        role    = "roles/bigquery.dataOwner"
        members = ["serviceAccount:thesis-poc-on-automated-kyc-sa@thesis-poc-on-automated-kyc.iam.gserviceaccount.com"]
      }
    ]
  }
]

gcs = [
  {
    bucket_name                 = "kyc-document-upload-bucket"
    location                    = "US"
    project_id                  = "thesis-poc-on-automated-kyc"
    storage_class               = "STANDARD"
    uniform_bucket_level_access = true
    versioning                  = true
  },
  {
    bucket_name                 = "kyc-document-processor-bucket"
    location                    = "US"
    project_id                  = "thesis-poc-on-automated-kyc"
    storage_class               = "STANDARD"
    uniform_bucket_level_access = true
    versioning                  = true
  },
  {
    bucket_name                 = "kyc-document-classifier-dataset"
    location                    = "US"
    project_id                  = "thesis-poc-on-automated-kyc"
    storage_class               = "STANDARD"
    uniform_bucket_level_access = true
    versioning                  = true
  },
  {
    bucket_name                 = "kyc-cloud-func-source-code-bucket"
    location                    = "US"
    project_id                  = "thesis-poc-on-automated-kyc"
    storage_class               = "STANDARD"
    uniform_bucket_level_access = true
    versioning                  = true
  }
]

cloud_function = [
  {
    name                  = "doc-classifier-func"
    runtime               = "python310"
    description           = "Document classifier cloud function"
    entry_point           = "process_document_trigger"
    project_id            = "thesis-poc-on-automated-kyc"
    region                = "us-east1"
    service_account_email = "thesis-poc-on-automated-kyc-sa@thesis-poc-on-automated-kyc.iam.gserviceaccount.com"
    environment_variables = {
      PROJECT_ID         = "thesis-poc-on-automated-kyc"
      PROCESSOR_ID       = "338236d85074a77a"
      LOCATION           = "us"
      DESTINATION_BUCKET = "kyc-document-processor-bucket"
    }
    source_archive_bucket = "kyc-cloud-func-source-code-bucket"
    event_trigger = {
      event_type           = "google.storage.object.finalize"
      resource             = "kyc-document-classifier-dataset"
      failure_policy_retry = true
    }
    source_code_folder_name = "doc-classifier"
    require_source_zip      = true
    upload_zip              = true
  },
  {
    name                  = "doc-processor-func"
    runtime               = "python310"
    description           = "Document Processor cloud function"
    entry_point           = "process_document_trigger"
    project_id            = "thesis-poc-on-automated-kyc"
    region                = "us-east1"
    service_account_email = "thesis-poc-on-automated-kyc-sa@thesis-poc-on-automated-kyc.iam.gserviceaccount.com"
    environment_variables = {
      PROJECT_ID   = "thesis-poc-on-automated-kyc"
      LOCATION     = "us"
      PROCESSOR_ID = "47e7ce9d4d4025a"
      DATASET_ID   = "IdentityDocumentsDataset"
      TABLE_ID     = "ExtractedData"
    }
    source_archive_bucket = "kyc-cloud-func-source-code-bucket"
    event_trigger = {
      event_type           = "google.storage.object.finalize"
      resource             = "kyc-document-processor-bucket"
      failure_policy_retry = true
    }
    source_code_folder_name = "doc-processor"
    require_source_zip      = true
    upload_zip              = true
  },
  {
    name                  = "doc-upload-func"
    runtime               = "python310"
    description           = "Document Upload cloud function"
    entry_point           = "upload_document"
    project_id            = "thesis-poc-on-automated-kyc"
    region                = "us-east1"
    trigger_http          = true
    service_account_email = "thesis-poc-on-automated-kyc-sa@thesis-poc-on-automated-kyc.iam.gserviceaccount.com"
    environment_variables = {
      BUCKET_NAME = "kyc-document-upload-bucket"
    }
    source_archive_bucket   = "kyc-cloud-func-source-code-bucket"
    source_code_folder_name = "doc-upload-function"
    require_source_zip      = true
    upload_zip              = true
  }
]