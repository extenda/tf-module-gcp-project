variable project_id {
  description = "Project ID where we will create the service account"
}

# Role permission bindings
variable iam_roles {
  type = map
}

variable create_service_account {
  type = bool
  description = "If this Service Account should be created."
}
