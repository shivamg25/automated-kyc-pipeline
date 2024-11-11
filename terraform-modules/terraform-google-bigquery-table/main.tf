locals {
  role_binding = tolist(flatten([for item in var.role_bind_table : [for member in item["members"] : {
    role   = item["role"]
    member = member
  }]]))
}

resource "google_bigquery_table" "main" {
  dataset_id          = var.dataset_id
  friendly_name       = var.table_id
  table_id            = var.table_id
  labels              = var.table_labels
  schema              = var.schema
  clustering          = var.clustering
  expiration_time     = var.expiration_time
  project             = var.project_id
  deletion_protection = var.deletion_protection

  time_partitioning {
    type          = var.time_partitioning_type
    field         = var.time_partitioning_field
    expiration_ms = var.expiration_ms
  }
}

resource "google_bigquery_table_iam_member" "member" {
  for_each   = { for item in local.role_binding : index(local.role_binding, item) => item }
  project    = var.project_id
  dataset_id = var.dataset_id
  table_id   = google_bigquery_table.main.table_id
  role       = each.value["role"]
  member     = each.value["member"]
}