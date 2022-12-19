variable clan_roles {
  type        = list(string)
  description = "Roles to be added to the clan's group in the staging project"
}

variable project_id {
  type        = string
  description = "Project id where roles will be added"
}

variable clan_gsuite_group {
  type        = string
  description = "Clan's gsuite group name"
}

variable domain {
  type        = string
  description = "Domain name of the organization"
}

variable env_name {
  type        = string
  description = "Environment name (staging/prod). Creation of some resources depends on env_name"
}
