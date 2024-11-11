output "table_id" {
  value       = google_bigquery_table.main.table_id
  description = "Unique id for the table being provisioned"
}

output "table_name" {
  value       = google_bigquery_table.main.friendly_name
  description = "Friendly name for the table being provisioned"
}