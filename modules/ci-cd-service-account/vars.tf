variable project {
  description = "Project where we will create the service account"
}

# Role permission bindings
variable iam_roles {
  type = map
  default = {
      r0 = "roles/iam.serviceAccountUser",
      r1 = "roles/run.admin",
      r2 = "roles/storage.admin" 
  }
}

variable create_ci_cd_service_account {}