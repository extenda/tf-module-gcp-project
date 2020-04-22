variable parent_project_id {
  type        = string
  description = "ID of the project to which add additional IAM roles for current project's CI/CD service account. Don't add roles if value is empty"
}

variable service_account {
  type        = string
  description = "Service account email to add IAM roles in parent project for"
}

variable parent_project_iam_roles {
  type        = list(string)
  description = "List of IAM Roles to add to the parent project"
}

variable gcr_project_id {
  type        = string
  description = "ID of the project hosting Google Container Registry"
}

variable gcr_project_iam_roles {
  type        = list(string)
  description = "List of IAM Roles to add GCR project"
}

variable gke_service_account {
  type        = string
  description = "GKE service account email that IAM roles will be added to in the parent project"
}

variable gke_parent_iam_roles {
  type        = list(string)
  description = "List of IAM Roles to add to the parent project"
}

variable gke_gcr_iam_roles {
  type        = list(string)
  description = "List of IAM Roles to add to the GCR project"
}
