variable project_id {
  description = "Project ID where we will create the service account"
}

# variable account_id {
#   description = "The service account ID"
# }

variable services {
  type        = any
  description = "TODO"
}

variable display_name {
  description = "The service account display name"
}

variable iam_roles {
  type        = map
  description = "Role permission bindings"
}

variable create_service_account {
  type        = bool
  description = "If this Service Account should be created."
}
