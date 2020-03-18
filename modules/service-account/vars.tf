variable project_id {
  description = "Project ID where we will create the service account"
}

# variable account_id {
#   description = "The service account ID"
# }

variable services {
  type = list(object({
    name = string
    iam_roles = list(string)
  }))
}

# variable names {
#   type        = list(string)
#   description = "Names of the service accounts to create."
# }

variable display_name {
  description = "The service account display name"
}

# variable project_roles {
#   type        = list(string)
#   description = "Role permission bindings"
# }

# variable create_service_account {
#   type        = bool
#   description = "If this Service Account should be created."
# }
