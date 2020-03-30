variable project_id {
  description = "Project ID where we will create the service account"
}

variable services {
  type = list(object({
    name      = string
    iam_roles = list(string)
  }))
  description = "Map of IAM Roles to assign to the Services Service Account"
}

variable create_service_account {
  type        = bool
  description = "If the Service Account should be created"
}

variable create_service_group {
  type        = bool
  description = "If the Service GSuite Group should be created"
}

variable impersonated_user_email {
  type        = string
  description = "Email account of GSuite Admin user to impersonate for creating GSuite Groups. If not provided, will default to `terraform@<var.domain>`"
  default     = ""
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
