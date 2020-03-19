variable project_id {
  description = "Project ID where we will create the service account"
}

variable services {
  type = list(object({
    name      = string
    iam_roles = list(string)
  }))
}

# variable display_name {
#   description = "The service account display name"
# }
