variable "name" {
  type        = string
  description = "(Required) A user-defined name of the function. Function names must be unique globally."
}

variable "runtime" {
  type        = string
  description = "(Required) The runtime in which the function is going to run. Eg. nodejs16, python39, dotnet3, go116, java11, ruby30, php74, etc. Check the official doc for the up-to-date list."
  default     = "python39"
}

variable "description" {
  type        = string
  description = "(Optional) Description of the function."
  default     = null
}

variable "project_id" {
  type        = string
  description = "GCP Project ID"
}

variable "available_memory_mb" {
  type        = number
  description = " (Optional) Memory (in MB), available to the function. Default value is 256. Possible values include 128, 256, 512, 1024, etc."
  default     = 256
}

variable "entry_point" {
  type        = string
  description = " (Optional) Name of the function that will be executed when the Google Cloud Function is triggered."
}

variable "source_code_folder_name" {
  type        = string
  description = "Source code folder name"
  default     = null
}

variable "region" {
  type        = string
  description = "GCP Region"
  default     = null
}

variable "timeout" {
  type        = number
  description = "(Optional) Timeout (in seconds) for the function. Default value is 60 seconds. Cannot be more than 540 seconds."
  default     = 120
}

variable "trigger_http" {
  type        = bool
  description = "(Optional) Boolean variable. Any HTTP request (of a supported type) to the endpoint will trigger function execution. Supported HTTP request types are: POST, PUT, GET, DELETE, and OPTIONS. Endpoint is returned as https_trigger_url. Cannot be used with event_trigger."
  default     = false
}

variable "https_trigger_security_level" {
  type        = string
  description = "(Optional) The security level for the function. The following options are available:"
  default     = "SECURE_ALWAYS"
}

variable "ingress_settings" {
  type        = string
  description = "(Optional) String value that controls what traffic can reach the function. Allowed values are ALLOW_ALL, ALLOW_INTERNAL_AND_GCLB and ALLOW_INTERNAL_ONLY. Check ingress documentation to see the impact of each settings value. Changes to this field will recreate the cloud function."
  default     = "ALLOW_ALL"
}

variable "labels" {
  type        = map(string)
  description = " (Optional) A set of key/value label pairs to assign to the function. Label keys must follow the requirements at https://cloud.google.com/resource-manager/docs/creating-managing-labels#requirements."
  default     = {}
}

variable "service_account_email" {
  type        = string
  description = "(Optional) If provided, the self-provided service account to run the function with."
}

variable "environment_variables" {
  type        = map(string)
  description = "(Optional) A set of key/value environment variable pairs to assign to the function."
}

variable "source_archive_bucket" {
  type        = string
  description = "(Optional) The GCS bucket containing the zip archive which contains the function."
  default     = null
}

variable "source_archive_object" {
  type        = string
  description = "(Optional) The source archive object (file) in archive bucket."
  default     = null
}

variable "max_instances" {
  type        = number
  description = "(Optional) The limit on the maximum number of function instances that may coexist at a given time."
  default     = 100
}

variable "min_instances" {
  type        = number
  description = " (Optional) The limit on the minimum number of function instances that may coexist at a given time."
  default     = 0
}

variable "event_trigger" {
  type = object({
    event_type           = optional(string)
    resource             = optional(string)
    failure_policy_retry = optional(bool)
  })
  description = "Event trigger object"
  default     = null
}

variable "require_source_zip" {
  type        = bool
  description = "Bool flag to use the source"
  default     = true
}

variable "upload_zip" {
  type        = bool
  default     = true
  description = "Bool flag to use the upload zip"
}