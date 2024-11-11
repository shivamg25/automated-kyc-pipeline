# Bigquery Dataset

variable "bq_dataset" {
  description = "List of object of BQ Dataset"
  default     = []
  type = list(object({
    dataset_id     = string
    dataset_name   = string
    description    = optional(string)
    location       = optional(string)
    project_id     = string
    dataset_labels = optional(map(string))
    role_bind_dataset = optional(list(object({
      role    = string
      members = list(string)
    })))
  }))
}


// Table Variables

variable "bq_table" {
  description = "List of object of BQ Tables"
  default     = []
  type = list(object({
    table_id            = string
    dataset_name        = string
    table_labels        = optional(map(string))
    project_id          = string
    deletion_protection = optional(bool)
    role_bind_table = optional(list(object({
      role    = string
      members = list(string)
    })))
  }))
}

# IAM Service account

variable "sa" {
  description = "List of object of SA"
  default     = []
  type = list(object({
    account_id      = string
    display_name    = optional(string)
    project_id      = string
    create_sa_key   = optional(bool)
    description     = optional(string)
    public_key_type = optional(string)
  }))
}

# GCS

variable "gcs" {
  description = "List of Object of GCS"
  default     = []
  type = list(object({
    bucket_name                 = string
    location                    = optional(string)
    force_destroy               = optional(bool)
    project_id                  = string
    storage_class               = optional(string)
    labels                      = optional(map(string))
    uniform_bucket_level_access = optional(bool)
    versioning                  = optional(bool)
  }))
}

# Cloud Functions

variable "cloud_function" {
  description = "List of Object of Cloud functions"
  default     = []
  type = list(object({
    name                  = string
    runtime               = optional(string)
    description           = optional(string)
    entry_point           = optional(string)
    project_id            = string
    region                = optional(string)
    trigger_http          = optional(bool)
    labels                = optional(map(string))
    service_account_email = string
    environment_variables = optional(map(string))
    source_archive_bucket = optional(string)
    event_trigger = optional(object({
      event_type           = string
      resource             = string
      failure_policy_retry = bool
    }))
    source_code_folder_name = optional(string)
    require_source_zip      = optional(bool)
    upload_zip              = optional(bool)
  }))
}