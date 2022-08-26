variable jit_access {
  type = list(object({
    group     = string
    iam_roles = list(string)
  }))
  description = "Map of IAM Roles to assign to the group"
}

variable create_jit_access {
  type        = bool
  description = "If the eligible roles should be created"
}

variable project_id {
  description = "Project ID where we will create the iam roles"
  type        = string
}
