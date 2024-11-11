resource "google_cloudfunctions_function" "function" {
  name                         = var.name
  runtime                      = var.runtime
  description                  = var.description
  project                      = var.project_id
  available_memory_mb          = var.available_memory_mb
  timeout                      = var.timeout
  entry_point                  = var.entry_point
  region                       = var.region
  trigger_http                 = var.trigger_http
  ingress_settings             = var.ingress_settings
  https_trigger_security_level = var.https_trigger_security_level
  labels                       = var.labels
  service_account_email        = var.service_account_email
  environment_variables        = var.environment_variables
  source_archive_bucket        = var.source_archive_bucket
  source_archive_object        = var.upload_zip ? google_storage_bucket_object.code_upload_bucket[0].name : var.source_archive_object
  max_instances                = var.max_instances
  min_instances                = var.min_instances

  dynamic "event_trigger" {
    for_each = var.event_trigger != null ? [var.event_trigger] : []
    content {
      event_type = var.event_trigger.event_type
      resource   = var.event_trigger.resource

      failure_policy {
        retry = lookup(var.event_trigger, "failure_policy_retry", false)
      }
    }
  }
}

data "archive_file" "cf_source_zip" {
  count       = var.require_source_zip ? 1 : 0
  type        = "zip"
  source_dir  = "${path.root}/${var.source_code_folder_name}"
  output_path = "${path.root}/${var.source_code_folder_name}.zip"
}

resource "google_storage_bucket_object" "code_upload_bucket" {
  count  = var.upload_zip ? 1 : 0
  name   = "${var.source_code_folder_name}.zip"
  source = var.require_source_zip ? data.archive_file.cf_source_zip[0].output_path : "${path.root}/${var.source_code_folder_name}.zip"
  bucket = var.source_archive_bucket
}