variable project_id {
  description = "Local (clan) Project ID where service account is created"
}

variable services {
  type = list(object({
    name      = string
    iam_roles = list(string)
  }))
  description = "List of services with IAM roles"
}

variable common_iam_roles {
  description = "List of IAM Roles to assign to every Services Service Account in Tribe project"
  type        = list(string)
  default     = []
}

variable sa_depends_on {
  description = "Service Account which this module depends on"
  type        = any
}

variable service_account {
  type        = string
  description = "Service account email to add IAM roles in parent project for"
}

variable dns_project_id {
  type        = string
  description = "ID of the project hosting Google Cloud DNS"
}

variable dns_project_iam_roles {
  type        = list(string)
  description = "List of IAM Roles to add to DNS project"
}

variable gcr_project_id {
  type        = string
  description = "ID of the project hosting Google Container Registry"
}

variable gcr_project_iam_roles {
  type        = list(string)
  description = "List of IAM Roles to add GCR project"
}

variable service_account_exists {
  type        = bool
  description = "If service_account for service exists or not"
}

variable project_type {
  description = "What project type this is"
  type        = string
}

variable env_name {
  type        = string
  description = "Environment name (staging/prod). Creation of some resources depends on env_name"
}

variable platform_project_id {
  type        = string
  description = "ID of the project to which add IAM roles for Binary Auth."
}

variable binary_auth_sa {
  type        = string
  description = "Binary Auth default service account"
}

variable binary_api_enabled {
  description = "Check if Binary Auth API is enabled"
  type        = bool
  default     = false
}

variable cloud_run_default_sa {
  description = "Cloud Run default service account"
  type        = string
  default     = ""
}

variable cloud_run_api_enabled {
  description = "Check if Cloud Run API is enabled"
  type        = bool
  default     = false
}

variable compute_sa {
  type        = string
  description = "Compute Engine default service account"
}

variable compute_project_iam_roles {
  type        = list(string)
  description = "List of IAM Roles to add to default compute service account"
}
