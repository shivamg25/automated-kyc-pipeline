locals {
  role_binding = tolist(flatten([for item in var.role_bind_dataset : [for member in item["members"] : {
    role   = item["role"]
    member = member
  }]]))
}

resource "google_bigquery_dataset" "main" {
  dataset_id                  = var.dataset_id
  friendly_name               = var.dataset_name
  description                 = var.description
  location                    = var.location
  delete_contents_on_destroy  = var.delete_contents_on_destroy
  default_table_expiration_ms = var.default_table_expiration_ms
  project                     = var.project_id
  labels                      = var.dataset_labels

  dynamic "default_encryption_configuration" {
    for_each = var.encryption_key == null ? [] : [var.encryption_key]
    content {
      kms_key_name = var.encryption_key
    }
  }
}

resource "google_bigquery_dataset_iam_member" "member" {
  project    = var.project_id
  for_each   = { for item in local.role_binding : index(local.role_binding, item) => item }
  dataset_id = google_bigquery_dataset.main.dataset_id
  role       = each.value["role"]
  member     = each.value["member"]
}