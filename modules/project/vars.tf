variable credentials {
  description = "JSON encoded service account credentials file with rights to run the Project Factory. If this file is absent Terraform will fail to provision the Project."
}

variable name {
  description = "The name for the project "
}

variable "random_project_id" {
  type = bool
  description = "Adds a suffix of 4 random characters to the project_id"
  default = true
}

variable org_id {
  description = "The organization ID"
}

variable folder_id {
  description = "The ID of a folder to host this project"
}

variable billing_account {
  description = "The ID of the billing account to associate this project with"
}

variable activate_apis {
  type = list(string)
  description = "The list of apis to activate within the project"
}

variable default_service_account {
  description = "Project default service account setting: can be one of delete, deprivilege, disable, or keep."
  default = "deprivilege"
}

variable create_ci_cd_service_account {
  description = "If the CI/CD Service Account should be created"
  type        = bool
  default     = true
}

variable "ci_cd_sa_iam_roles" {
  type = map
  default = {
      r0 = "roles/iam.serviceAccountUser",
      r1 = "roles/run.admin",
      r2 = "roles/storage.admin" 
  }
  description = "Map of IAM Roles to assign to the CI/CD Pipeline Service Account"
}
