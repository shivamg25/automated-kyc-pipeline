variable "account_id" {
  description = " (Required) The account id that is used to generate the service account email address and a stable unique id. It is unique within a project, must be 6-30 characters long, and match the regular expression [a-z]([-a-z0-9]*[a-z0-9]) to comply with RFC1035. Changing this forces a new service account to be created."
  type        = string
}

variable "display_name" {
  description = " (Optional) The display name for the service account. Can be updated without creating a new resource."
  type        = string
  default     = null
}

variable "project_id" {
  description = "(Optional) The ID of the project that the service account will be created in. Defaults to the provider project configuration."
  type        = string
}

variable "create_sa_key" {
  description = "Bool flag to create a key for the service account"
  type        = bool
  default     = false
}

variable "description" {
  type        = string
  description = "(Optional) A text description of the service account. Must be less than or equal to 256 UTF-8 bytes."
  default     = null
}

variable "public_key_type" {
  type        = string
  default     = "TYPE_X509_PEM_FILE"
  description = " (Optional) The output format of the private key. TYPE_GOOGLE_CREDENTIALS_FILE is the default output format."
}