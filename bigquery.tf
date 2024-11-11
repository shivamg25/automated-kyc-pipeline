module "bq_dataset" {
  source            = "./terraform-modules/terraform-google-bigquery-dataset"
  for_each          = var.bq_dataset == tolist(null) ? {} : { 
    for eachDataset in var.bq_dataset : eachDataset.dataset_name => eachDataset }
  dataset_id        = each.value.dataset_id
  dataset_name      = each.value.dataset_name
  description       = each.value.description
  location          = each.value.location
  project_id        = each.value.project_id
  dataset_labels    = each.value.dataset_labels
  role_bind_dataset = each.value.role_bind_dataset
  depends_on        = [module.service_account]
}

module "bq_table" {
  source              = "./terraform-modules/terraform-google-bigquery-table"
  for_each            = var.bq_table == tolist(null) ? {} : { 
    for eachTable in var.bq_table : eachTable.table_id => eachTable }
  dataset_id          = module.bq_dataset[each.value.dataset_name].dataset_id
  dataset_name        = each.value.dataset_name
  table_id            = each.value.table_id
  table_labels        = each.value.table_labels
  schema              = file("${path.module}/bq_schema.json")
  deletion_protection = each.value.deletion_protection
  project_id          = each.value.project_id
  role_bind_table     = each.value.role_bind_table
  depends_on          = [module.service_account]
}