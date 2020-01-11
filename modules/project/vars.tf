variable credentials {
  description = "JSON encoded service account credentials file with rights to run the Project Factory. If this file is absent Terraform will fail to provision the Project."
}

variable name {
  description = "The name for the project "
}

variable org_id {
  description = "The organization ID"
}

variable folder_id {
  description = "The ID of a folder to host this project  "
}

variable billing_account {
  description = "The ID of the billing account to associate this project with "
}

variable activate_apis {
  type = list(string)
  description = "The list of apis to activate within the project"
}

variable create_ci_cd_service_account {
  description = "If the CI/CD Service Account should be created"
  type        = bool
  default     = true
}
