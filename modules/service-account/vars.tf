variable project_id {
  description = "Project ID where we will create the service account"
}

variable services {
  type = list(object({
    name      = string
    iam_roles = list(string)
  }))
}

variable create_service_account {
  type        = bool
  description = "If this Service Account should be created."
}
