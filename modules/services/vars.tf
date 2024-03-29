variable project_id {
  description = "Project ID where we will create the service account"
}

variable services {
  type = list(object({
    name      = string
    iam_roles = list(string)
  }))
  description = "Map of IAM Roles to assign to the Services Service Account"

  validation {
    condition = length([
      for s in var.services : s
      if can(regex("^[a-z](?:[-a-z0-9]{4,28}[a-z0-9])$", s.name))
    ]) == length(var.services)

    error_message = "For the account id that is used to generate the service account email address, the name '${join(", ", [for s in var.services : s.name if can(regex("^[a-z](?:[-a-z0-9]{4,28}[a-z0-9])$", s.name)) == false])}' doesn't match regexp ^[a-z](?:[-a-z0-9]{4,28}[a-z0-9])$"
  }
}

variable common_iam_roles {
  description = "Default list of IAM Roles to assign to every Services Service Account"
  type        = list(string)
  default     = []
}

variable create_service_account {
  type        = bool
  description = "If the Service Account should be created"
}

variable create_service_group {
  type        = bool
  description = "If the Service GSuite Group should be created"
}

variable domain {
  type        = string
  description = "Domain name of the Organization - needed for var impersonated_user_email"
}

variable service_group_name {
  type        = string
  description = "The name of the group that will be created for services"
}

variable clan_gsuite_group {
  type        = string
  description = "The name of the clan group that needs to be added to the Service GSuite Group"
}

variable env_name {
  type        = string
  description = "Environment name (staging/prod). Creation of some resources depends on env_name"
}
