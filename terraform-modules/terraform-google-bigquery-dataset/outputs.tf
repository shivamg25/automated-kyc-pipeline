output "bigquery_dataset" {
  value       = google_bigquery_dataset.main
  description = "Bigquery dataset resource."
}

output "dataset_id" {
  value       = google_bigquery_dataset.main.dataset_id
  description = "Bigquery dataset id."
}