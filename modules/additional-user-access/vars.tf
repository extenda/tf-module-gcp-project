variable project_id {
  description = "Project ID to add IAM roles to"
}

variable additional_user_access {
  type = list(object({
    name      = string
    iam_roles = list(string)
    members   = list(string)
  }))
  description = "List of IAM Roles to assign to groups and users"
}

variable clan_gsuite_group {
  type        = string
  description = "The name of the clan gsuite group"
}

variable domain {
  type        = string
  description = "Domain name of the Organization - needed for var impersonated_user_email"
}

variable env_name {
  type        = string
  description = "Environment name (staging/prod). Creation of some resources depends on env_name"
}

variable create_custom_roles {
  description = "If the Custom Roles should be created"
  type        = bool
}
