variable "name" {
  description = "Name of the IAM role"
  type        = string
  default     = "cloudcoreops-app"
}

variable "oidc_provider_arn" {
  description = "ARN of the cluster's IAM OIDC provider"
  type        = string
}

variable "oidc_provider_url" {
  description = "OIDC provider URL without the https:// scheme"
  type        = string
}

variable "namespace" {
  description = "Kubernetes namespace of the service account"
  type        = string
}

variable "service_account" {
  description = "Kubernetes service account name"
  type        = string
  default     = "cloudcoreops-app"
}

variable "policy_arns" {
  description = "Managed policy ARNs to attach"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags applied to the role"
  type        = map(string)
  default     = {}
}
