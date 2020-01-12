variable project {
  description = "Project where we will create the service account"
}

# Role permission bindings
variable iam_roles {
  type = map
}

variable create_ci_cd_service_account {}
