module "cloud_function" {
  source                  = "./terraform-modules/terraform-google-functions"
  for_each                = var.cloud_function == tolist(null) ? {} : { 
    for eachFunction in var.cloud_function : eachFunction.name => eachFunction }
  name                    = each.value.name
  runtime                 = each.value.runtime
  description             = each.value.description
  entry_point             = each.value.entry_point
  project_id              = each.value.project_id
  region                  = each.value.region
  trigger_http            = each.value.trigger_http
  labels                  = each.value.labels
  service_account_email   = each.value.service_account_email
  environment_variables   = each.value.environment_variables
  source_archive_bucket   = each.value.source_archive_bucket
  event_trigger           = each.value.event_trigger
  source_code_folder_name = each.value.source_code_folder_name
  require_source_zip      = each.value.require_source_zip
  upload_zip              = each.value.upload_zip
  depends_on              = [module.service_account, module.gcs, module.bq_table]
}