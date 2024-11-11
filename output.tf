output "bigquery_dataset" {
  value       = {for k,v in module.bq_dataset : k => v.bigquery_dataset}
  description = "Bigquery dataset resource."
}

output "dataset_id" {
  value       = {for k,v in module.bq_dataset : k => v.dataset_id}
  description = "Bigquery dataset id."
}

output "table_id" {
  value       = {for k,v in module.bq_table : k => v.table_id}
  description = "Unique id for the table being provisioned"
}

output "table_name" {
  value       = {for k,v in module.bq_table : k => v.table_name}
  description = "Friendly name for the table being provisioned"
}

output "functions_id" {
  value = {for k,v in module.cloud_function : k => v.id}
  description = "Cloud functions Id"
}

output "https_trigger_url" {
  value = {for k,v in module.cloud_function : k => v.https_trigger_url}
  description = "Cloud functions Http URL"
}

output "sa_id" {
  value = {for k,v in module.service_account : k => v.id}
  description = "GCP Service Account Id"
}

output "sa_email" {
  value = {for k,v in module.service_account : k => v.email}
  description = "GCP Service Account Email"
}

output "bucket_self_link" {
  value = {for k,v in module.gcs : k => v.self_link}
}

output "bucket_url" {
  value = {for k,v in module.gcs : k => v.url}
}
