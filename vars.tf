variable credentials {
  description = "JSON encoded service account credentials file with rights to run the Project Factory. If this file is absent Terraform will fallback to GOOGLE_APPLICATION_CREDENTIALS env variable."
  default     = null
}

variable name {
  description = "The name for the project"
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

variable github_organization {
  type        = string
  description = "GitHub organization to use GitHub prodifer with"
  default     = "extenda"
}

variable github_token_gcp_project {
  type        = string
  description = "GCP project that contains Secret Manager for Github token"
  default     = "tf-admin-90301274"
}

variable github_token_gcp_secret {
  type        = string
  description = "SGP secret name for GitHub token"
  default     = "github-token"
}

variable github_token {
  type        = string
  description = "GitHub token value (instead request GCP secret)"
  default     = ""
}

variable shared_vpc {
  type        = string
  description = "The ID of the host project which hosts the shared VPC"
  default     = ""
}

variable shared_vpc_subnets {
  type        = list(string)
  description = "List of subnets fully qualified subnet IDs (ie. projects/$project_id/regions/$region/subnetworks/$subnet_id)"
  default     = []
}

variable default_service_account {
  description = "Project default service account setting: can be one of delete, deprivilege, disable, or keep."
  default     = "deprivilege"
}

variable labels {
  description = "Map of labels for the project"
  type        = map(string)
  default     = {}
}

## Terraform state bucket
variable bucket_name {
  description = "The name of the bucket that will contain terraform state - must be globally unique"
}

variable bucket_labels {
  description = " A map of key/value label pairs to assign to the bucket"
  type        = map
  default     = {}
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
        "roles/cloudsql.editor",
        "roles/iam.serviceAccountUser",
        "roles/run.admin",
        "roles/storage.admin",
        "roles/cloudfunctions.admin",
        "roles/secretmanager.secretAccessor",
        "roles/dataflow.admin",
        "roles/bigquery.admin",
        "roles/datastore.importExportAdmin",
        "roles/monitoring.admin",
        "roles/compute.loadBalancerAdmin",
        "roles/dns.admin"
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
  default     = []
  description = "Map of IAM Roles to assign to the Services Service Account"
}

variable repositories {
  description = "The GitHub repositories to update"
  type        = list(string)
  default     = []
}

variable common_iam_roles {
  description = "Default list of IAM Roles to assign to every Services Service Account"
  type        = list(string)
  default     = ["roles/monitoring.metricWriter", "roles/logging.logWriter", "roles/monitoring.viewer", "roles/cloudtrace.agent", "roles/secretmanager.secretAccessor"]
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
  default     = ""
}

variable domain {
  type        = string
  description = "Domain name of the Organization"
}

variable env_name {
  type        = string
  description = "Environment name (staging/prod). Creation of some resources depends on env_name"
  default     = ""
}

variable impersonated_user_email {
  type        = string
  description = "Email account of GSuite Admin user to impersonate for creating GSuite Groups. If not provided, will default to `terraform@<var.domain>`"
  default     = ""
}

variable parent_project_id {
  type        = string
  description = "ID of the project to which add additional IAM roles for current project's CI/CD service account. Ignore if empty"
  default     = ""
}

variable parent_project_iam_roles {
  type        = list(string)
  description = "List of IAM Roles to add to the parent project"
  default = [
    "roles/monitoring.admin",
    "roles/iam.serviceAccountUser"
  ]
}

variable dns_project_id {
  type        = string
  description = "ID of the project hosting Google Cloud DNS"
  default     = ""
}

variable dns_project_iam_roles {
  type        = list(string)
  description = "List of IAM Roles to add to DNS project"
  default = [
    "roles/dns.admin"
  ]
}

variable gcr_project_id {
  type        = string
  description = "ID of the project hosting Google Container Registry"
  default     = ""
}

variable gcr_project_iam_roles {
  type        = list(string)
  description = "List of IAM Roles to add GCR project"
  default = [
    "roles/storage.admin",
    "roles/firebase.admin"
  ]
}

variable additional_user_access {
  type = list(object({
    name      = string
    iam_roles = list(string)
    members   = list(string)
  }))
  default     = []
  description = "List of IAM Roles to assign to groups and users"
}

## Service Accounts

variable service_accounts {
  type = list(object({
    name      = string
    iam_roles = list(string)
  }))
  default     = []
  description = "Map of IAM Roles to assign to the Service Account"
}

variable create_sa {
  description = "If the Service Account should be created"
  type        = bool
  default     = true
}

variable create_custom_roles {
  description = "If the Custom Roles from the additioanl-use-access submodule should be created"
  type        = bool
  default     = true
}

# Custom external IAM roles

variable custom_external_roles {
  description = "Map of service or service account to external projects to list of iam roles for add"
  type        = map(map(list(string)))
  default     = {}
}

variable gke_host {
  description = "Kubernetes endpoint"
  type        = string
  default     = "no-gke-host"
}

variable gke_ca_certificate {
  description = "Kubernetes certificate"
  type        = string
  default     = ""
}

variable project_type {
  description = "what type of project this is applied to"
  type        = string
  default     = "clan_project"
}

# Pact-broker

variable pactbroker_user_secret {
  type        = string
  description = "GCP secret name for pact-broker user"
  default     = "pactbroker_ro_username"
}

variable pactbroker_pass_secret {
  type        = string
  description = "GCP secret name for pact-broker password"
  default     = "pactbroker_ro_password"
}

variable create_pact_secrets {
  description = "If the pact-broker secrets should be created"
  type        = bool
  default     = false
}

variable pact_project_id {
  description = "GCP project that contains secrets for pact-broker"
  type        = string
  default     = "platform-prod-2481"
}

# slack alert token secret

variable slack_notify_secret {
  type        = string
  description = "GCP secret name for slack token"
  default     = "slack_notify_token"
}

variable pipeline_project_id {
  description = "GCP project that contains secrets for webhook url"
  type        = string
  default     = "pipeline-secrets-1136"
}

variable platform_project_id {
  type        = string
  description = "ID of the project to which add IAM roles for Binary Auth."
  default     = "platform-prod-2481"
}

# pubsub dlq handler

variable pubsub_dlq_sa {
  type = list(object({
    name      = string
    iam_roles = list(string)
  }))
  default = [
    {
      name = "pubsub-dlq-handler"
      iam_roles = [
        "roles/iam.serviceAccountTokenCreator",
        "roles/pubsub.subscriber"
      ]
    }
  ]
  description = "Map of IAM Roles to assign to the CI/CD Pipeline Service Account"
}

variable pubsub_dlq_sa_project_id {
  description = "Project id where the cloud function resides ( where we need invoker permission )"
  type = string
  default = "sre-prod-5462"
}

# JIT-access

variable jit_access {
  type = list(object({
    group     = string
    iam_roles = list(string)
  }))
  description = "Map of IAM Roles to assign to the group"
  default     = []
}

variable create_jit_access {
  type        = bool
  description = "If the eligible roles should be created"
  default     = false
}

variable clan_roles {
  type        = list(string)
  default     = []
  description = "Roles to be added to the clan's group in the staging project"
}
