variable "bucket_name" {
  type        = string
  description = "(Required) The name of the bucket."
}

variable "location" {
  type        = string
  description = "(Required) The GCS location."
  default     = "US"
}

variable "force_destroy" {
  type        = bool
  default     = false
  description = "(Optional, Default: false) When deleting a bucket, this boolean option will delete all contained objects. If you try to delete a bucket that contains objects, Terraform will fail that run."
}

variable "project_id" {
  type        = string
  description = "GCP Project Id"
}

variable "storage_class" {
  type        = string
  default     = "STANDARD"
  description = "(Optional, Default: 'STANDARD') The Storage Class of the new bucket. Supported values include: STANDARD, MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE, ARCHIVE."
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "(Optional) A map of key/value label pairs to assign to the bucket."
}

variable "uniform_bucket_level_access" {
  type        = bool
  default     = true
  description = "(Optional, Default: false) Enables Uniform bucket-level access access to a bucket."
}

variable "versioning" {
  type        = bool
  default     = true
  description = "(Required) While set to true, versioning is fully enabled for this bucket."
}