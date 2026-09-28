variable "db_instance_identifier" {
  description = "Identifier of the RDS instance to snapshot"
  type        = string
}

variable "snapshot_suffix" {
  description = "Suffix making the snapshot identifier unique, e.g. a date or release tag"
  type        = string
}

variable "tags" {
  description = "Tags applied to the snapshot"
  type        = map(string)
  default     = {}
}
