// Table Variables
variable "dataset_id" {
  description = "Unique ID for the dataset being provisioned."
  type        = string
}

variable "dataset_name" {
  description = "Unique ID for the dataset being provisioned."
  type        = string
}

variable "table_id" {
  description = "Id for the table"
  type        = string
}

variable "table_labels" {
  description = "Labels to be attached to the table"
  type        = map(string)
  default     = {}
}

variable "schema" {
  description = "Schema for the table"
  type        = string
  default     = ""
}

variable "clustering" {
  description = "Column names to use for data clustering. Up to four top-level columns are allowed, and should be specified in descending priority order."
  type        = list(string)
  default     = []
}

variable "expiration_time" {
  description = "The time when this table expires, in milliseconds since the epoch."
  type        = number
  default     = null
}

variable "project_id" {
  description = "Project where the dataset and table are created"
  type        = string
}

variable "deletion_protection" {
  description = "Whether or not to allow Terraform to destroy the instance. Unless this field is set to false in Terraform state, a terraform destroy or terraform apply that would delete the instance will fail"
  type        = bool
  default     = false
}

variable "time_partitioning_type" {
  description = "The supported types are DAY, HOUR, MONTH, and YEAR, which will generate one partition per day, hour, month, and year, respectively."
  type        = string
  default     = "DAY"
}

variable "time_partitioning_field" {
  description = "The field used to determine how to create a time-based partition. If time-based partitioning is enabled without this value, the table is partitioned based on the load time."
  type        = string
  default     = null
}

variable "require_partition_filter" {
  description = "If set to true, queries over this table require a partition filter that can be used for partition elimination to be specified."
  type        = bool
  default     = false
}

variable "expiration_ms" {
  description = "Number of milliseconds for which to keep the storage for a partition."
  type        = string
  default     = null
}

variable "role_bind_table" {
  description = "Role binding to be done for members on the table"
  type = list(object({
    role    = string
    members = list(string)
  }))
  default = []
}