module "service_account" {
  source          = "./terraform-modules/terraform-google-service-account"
  for_each        = var.sa == tolist(null) ? {} : { 
    for eachSA in var.sa : eachSA.account_id => eachSA }
  account_id      = each.value.account_id
  display_name    = each.value.display_name
  project_id      = each.value.project_id
  create_sa_key   = each.value.create_sa_key
  description     = each.value.description
  public_key_type = each.value.public_key_type
}