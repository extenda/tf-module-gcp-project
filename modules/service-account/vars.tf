variable project_id {
  description = "Project ID where we will create the service account"
}

variable service_accounts {
  type = list(object({
    name               = string
    iam_roles          = list(string)
    external_iam_roles = map(list(string))
  }))
  description = "Map of IAM Roles to assign to the Service Account"
}

variable create_service_account {
  type        = bool
  description = "If the Service Account should be created"
}

variable external_project_id {
  description = "External project ID where additional roles will be assigned"
}
