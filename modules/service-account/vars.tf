variable project_id {
  description = "Project ID where we will create the service account"
}

variable service_accounts {
  type = list(object({
    name      = string
    iam_roles = list(string)
    # SA-level IAM bindings allow granting roles ON specific target service accounts
    sa_iam_bindings = optional(list(object({
      target_sa = string
      role      = string
      condition = optional(object({
        title       = string
        description = optional(string)
        expression  = string
      }))
    })), [])
  }))
  description = "Map of IAM Roles to assign to the Service Account. Includes optional sa_iam_bindings for resource-level IAM on other service accounts."

  validation {
    condition = length([
      for s in var.service_accounts : s
      if can(regex("^[a-z](?:[-a-z0-9]{4,28}[a-z0-9])$", s.name))
    ]) == length(var.service_accounts)

    error_message = "For the account id that is used to generate the service account email address, the name '${join(", ", [for s in var.service_accounts : s.name if can(regex("^[a-z](?:[-a-z0-9]{4,28}[a-z0-9])$", s.name)) == false])}' doesn't match regexp ^[a-z](?:[-a-z0-9]{4,28}[a-z0-9])$"
  }
}

variable create_service_account {
  type        = bool
  description = "If the Service Account should be created"
}

variable create_service_account_keys {
  type        = bool
  description = "If the Service Account keys should be created"
  default     = false
}
