variable "kubeconfig_path" {
  description = "Kubeconfig Path"
  type        = string
  default     = "~/.kube/config"
}

variable "kube_context" {
  description = "Kubernetes Context to Use"
  type        = string
  default     = ""
}

variable "namespace_name" {
  description = "Namespace Name"
  type        = string
  default     = ""
}

variable "use_namespace_labels" {
  description = "Use Namespace Labels"
  type        = bool
  default     = false
}

variable "namespace_labels" {
  description = "Namespace Labels"
  type        = map(string)
  default     = {}
}

variable "helm_config" {
  description = "Helm Config"
  type = list(object({
    release_name  = optional(string, "")
    chart_name    = string
    chart_repo    = string
    chart_version = string
    values_path   = optional(string, "")
  }))
  default = []

  validation {
    condition     = var.use_helm_custom_values ? alltrue([for c in var.helm_config : length(c.values_path) > 0]) : true
    error_message = "'values_path' must be defined when 'use_helm_custom_values' is true."
  }
}

variable "use_helm_custom_values" {
  description = "Use Helm Custom Values"
  type        = bool
  default     = false
}

variable "helm_custom_values" {
  description = "Helm Custom Values Path"
  type      = map(string)
  sensitive = true
  default   = {}
}

variable "create_custom_secrets" {
  description = "Create Custom Secrets"
  type        = bool
  default     = false
}

variable "custom_secrets" {
  description = "Custom Secrets Data"
  sensitive   = true
  type = list(object({
    name = string
    data = map(string)
    type = optional(string, "kubernetes.io/tls")
  }))
  default = []
}
