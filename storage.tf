module "gcs" {
  source                      = "./terraform-modules/terraform-google-storage"
  for_each                    = var.gcs == tolist(null) ? {} : { 
    for eachBucket in var.gcs : eachBucket.bucket_name => eachBucket }
  bucket_name                 = each.value.bucket_name
  location                    = each.value.location
  project_id                  = each.value.project_id
  storage_class               = each.value.storage_class
  labels                      = each.value.labels
  uniform_bucket_level_access = each.value.uniform_bucket_level_access
  versioning                  = each.value.versioning
}