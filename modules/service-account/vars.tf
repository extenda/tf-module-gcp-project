variable project_id {
  description = "Project ID where we will create the service account"
}

variable service_accounts {
  type = list(object({
    name      = string
    iam_roles = list(string)
  }))
  description = "Map of IAM Roles to assign to the Service Account"
}

variable create_service_account {
  type        = bool
  description = "If the Service Account should be created"
}

variable gcr_project_id {
  type        = string
  description = "ID of the project hosting Google Container Registry. Don't add roles if value is empty"
  default     = ""
}

variable parent_project_id {
  type        = string
  description = "ID of the parent project. Don't add roles if value is empty"
  default     = ""
}

