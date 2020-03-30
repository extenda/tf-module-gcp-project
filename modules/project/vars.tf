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
variable bucket_name {
  description = "The name of the bucket that will contain terraform state - must be globally unique"
}

## CI/CD Service Account

variable create_ci_cd_service_account {
  description = "If the CI/CD Service Account should be created"
  type        = bool
  default     = true
}

variable create_ci_cd_group {
  description = "If the Service GSuite Group should be created for the CI/CD Service Account"
  type        = bool
  default     = false
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

variable create_cloudrun_group {
  description = "If the Service GSuite Group should be created for the CloudRun Runtime Service Account"
  type        = bool
  default     = false
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
  default     = false
}

variable create_secret_manager_group {
  description = "If the Service GSuite Group should be created for the Secret Manager Access Service Account"
  type        = bool
  default     = false
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
  default = [
    {
      name = "foo"
      iam_roles = [
        "bar"
      ]
    }
  ]
  description = "Map of IAM Roles to assign to the Services Service Account"
}

variable create_service_sa {
  description = "If the Service Account for new Services should be created"
  type        = bool
  default     = true
}

variable create_services_group {
  description = "If the Service GSuite Group should be created for the Services (services variable)"
  type        = bool
  default     = true
}

variable service_group_name {
  type        = string
  description = "The name of the group that will be created for a service"
  default     = ""
}

variable clan_gsuite_group {
  type        = string
  description = "The name of the clan group that needs to be added to the Service GSuite Group"
}

variable domain {
  type        = string
  description = "Domain name of the Organization"
}
