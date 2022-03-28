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
