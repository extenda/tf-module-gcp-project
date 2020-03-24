variable credentials {
  description = "JSON encoded service account credentials file with rights to run the Project Factory. If this file is absent Terraform will fallback to GOOGLE_APPLICATION_CREDENTIALS env variable."
  default     = null
}

variable name {
  description = "The name for the project "
}

variable random_project_id {
  type        = bool
  description = "Adds a suffix of 4 random characters to the project_id"
  default     = true
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
  type        = list(string)
  description = "The list of apis to activate within the project"
}

variable default_service_account {
  description = "Project default service account setting: can be one of delete, deprivilege, disable, or keep."
  default     = "deprivilege"
}

## Terraform state bucket
variable tribe_name {
  description = "Tribe name that project belongs to"
}

variable clan_name {
  description = "Clan name that project belongs to"
}

## CI/CD Service Account

variable create_ci_cd_service_account {
  description = "If the CI/CD Service Account should be created"
  type        = bool
  default     = true
}

variable ci_cd_sa {
  type = list(object({
    name      = string
    iam_roles = list(string)
  }))
  default = [
    {
      name = "ci-cd-pipeline"
      iam_roles = [
        "roles/iam.serviceAccountUser",
        "roles/run.admin",
        "roles/storage.admin"
      ]
    }
  ]
  description = "Map of IAM Roles to assign to the CI/CD Pipeline Service Account"
}

## Cloud Run Service Account

variable create_cloudrun_service_account {
  description = "If the CloudRun Runtime Service Account should be created"
  type        = bool
  default     = true
}

variable cloudrun_sa {
  type = list(object({
    name      = string
    iam_roles = list(string)
  }))
  default = [
    {
      name = "cloudrun-runtime"
      iam_roles = [
        "roles/editor",
        "roles/secretmanager.secretAccessor"
      ]
    }
  ]
  description = "Map of IAM Roles to assign to the CloudRun Runtime Service Account"
}

## Secrets Access Service Account

variable create_secret_manager_service_account {
  description = "If the Secret Manager Access Service Account should be created"
  type        = bool
  default     = true
}

variable secret_manager_sa {
  type = list(object({
    name      = string
    iam_roles = list(string)
  }))
  default = [
    {
      name = "secret-accessor"
      iam_roles = [
        "roles/secretmanager.secretAccessor"
      ]
    }
  ]
  description = "Map of IAM Roles to assign to the Secret Manager Access Service Account"
}

variable services {
  type = list(object({
    name      = string
    iam_roles = list(string)
  }))
}

variable create_service_sa {
  description = "If the Service Account for new Service should be created"
  type        = bool
  default     = true
}
