variable "bucket_source_name" {
  type        = string
  description = "Name for source s3 bucket"
}

variable "replicate_prefix" {
  type        = string
  description = "Prefix to replicate, default \"\" for all objects. Note if specifying, must end in a /"
  default     = ""
}

variable "bucket_dest_name" {
  type        = string
  description = "Name for dest s3 bucket"
}

variable "replication_name" {
  type        = string
  description = "Short name to describe this replication"
}

variable "replication_prefix" {
  type        = string
  description = "Prefix to replicate, default \"\" for all objects. Note if specifying, must end in a /"
}

variable "versioning_enable" {
  description = "To enable or disable versioning"
  default = "Enabled"
}

variable "replication_policy_name" {
  description = "Policy name used for replication"
}

variable "replication_role_name" {
  description = "Role name used for replication"
}

variable "transition_to_ia" {
  description = "Days until transition to IA STANDARD storage class"
  default = 30
}

variable "transition_to_glacier" {
  description = "Days until transition to GLACIER storage class"
  default = 90
}

variable "source_lifecycle_name" {
  description = "ID for lifecycle config"
  default = "source-lifecycle"
}

variable "destination_storage_class" {
  description = "Destination storage class"
  default = "GLACIER"
}

variable "source_region" {
  description = "Source region"
}

variable "dest_region" {
  description = "Destination region"
}