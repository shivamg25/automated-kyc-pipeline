resource "google_service_account" "service_account" {
  account_id   = var.account_id
  display_name = var.display_name
  project      = var.project_id
}

resource "google_service_account_key" "key_creation" {
  for_each           = var.create_sa_key == true ? { key_type = "${var.public_key_type}" } : {}
  service_account_id = google_service_account.service_account.name
  public_key_type    = var.public_key_type
}

resource "google_project_iam_member" "service_account_owner" {
  project = var.project_id
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.service_account.email}"
}