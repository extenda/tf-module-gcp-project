locals {
  ci_cd_sa_email = var.create_ci_cd_service_account ? module.ci_cd_sa.email[var.ci_cd_sa[0].name] : ""
  secret_suffix  = var.env_name == "" ? "" : "_${upper(var.env_name)}"
  pubsub_sa      = "service-${module.project_factory.project_number}@gcp-sa-pubsub.iam.gserviceaccount.com"
}

module "project_factory" {
  source = "terraform-google-modules/project-factory/google"
  version = "10.0.1"

  name              = var.name
  random_project_id = var.random_project_id

  default_service_account = var.default_service_account

  org_id          = var.org_id
  folder_id       = var.folder_id
  billing_account = var.billing_account

  bucket_name       = var.bucket_name
  bucket_location   = "EU"
  bucket_project    = var.name
  bucket_versioning = true

  activate_apis = var.activate_apis
  labels        = var.labels

  svpc_host_project_id = var.shared_vpc
  shared_vpc_subnets   = var.shared_vpc_subnets
}

module "ci_cd_sa" {
  source = "./modules/services"

  create_service_account = var.create_ci_cd_service_account
  create_service_group   = var.create_ci_cd_group
  service_group_name     = var.service_group_name
  clan_gsuite_group      = var.clan_gsuite_group

  project_id = module.project_factory.project_id
  services   = var.ci_cd_sa
  domain     = var.domain
  env_name   = var.env_name
}

module "cloudrun_sa" {
  source = "./modules/services"

  create_service_account = var.create_cloudrun_service_account
  create_service_group   = var.create_cloudrun_group
  service_group_name     = var.service_group_name
  clan_gsuite_group      = var.clan_gsuite_group

  project_id = module.project_factory.project_id
  services   = var.cloudrun_sa
  domain     = var.domain
  env_name   = var.env_name
}

module "secret_manager_sa" {
  source = "./modules/services"

  create_service_account = var.create_secret_manager_service_account
  create_service_group   = var.create_secret_manager_group
  service_group_name     = var.service_group_name
  clan_gsuite_group      = var.clan_gsuite_group

  project_id = module.project_factory.project_id
  services   = var.secret_manager_sa
  domain     = var.domain
  env_name   = var.env_name
}

module "services_sa" {
  source = "./modules/services"

  create_service_account = var.create_service_sa
  create_service_group   = var.create_services_group
  service_group_name     = var.service_group_name
  clan_gsuite_group      = var.clan_gsuite_group
  common_iam_roles       = var.common_iam_roles

  project_id = module.project_factory.project_id
  services   = var.services
  domain     = var.domain
  env_name   = var.env_name
}

module "parent_project_iam" {
  source = "./modules/external-project-iam-roles"

  service_account_exists   = var.create_service_sa
  service_account          = local.ci_cd_sa_email
  parent_project_id        = var.parent_project_id
  parent_project_iam_roles = var.parent_project_iam_roles

  project_id       = module.project_factory.project_id
  services         = var.services
  common_iam_roles = var.common_iam_roles
  sa_depends_on    = module.services_sa.email

  dns_project_id        = var.dns_project_id
  dns_project_iam_roles = var.dns_project_iam_roles
  gcr_project_id        = var.gcr_project_id
  gcr_project_iam_roles = var.gcr_project_iam_roles
  project_type          = var.project_type
}

module "custom_external_roles" {
  source = "./modules/external-roles"

  roles_map  = var.custom_external_roles
  project_id = module.project_factory.project_id
  sa_depends_on = [
    module.ci_cd_sa.email,
    module.cloudrun_sa.email,
    module.secret_manager_sa.email,
    module.services_sa.email,
    module.service_accounts.email,
  ]
}

module "workload-identity" {
  source = "./modules/workload-identity"

  project_id         = module.project_factory.project_id
  cluster_project_id = var.parent_project_id
  services           = var.services
  sa_depends_on      = module.services_sa.email
}

module "github_secret" {
  source = "./modules/github-secret"

  github_token             = var.github_token
  github_token_gcp_project = var.github_token_gcp_project
  github_token_gcp_secret  = var.github_token_gcp_secret
  github_organization      = var.github_organization

  repositories = var.repositories

  create_secret = var.create_service_sa
  secret_name   = "GCLOUD_AUTH${local.secret_suffix}"
  secret_value  = try(lookup(module.ci_cd_sa.private_key_encoded, "ci-cd-pipeline", ""), "")
}

module "additional_user_access" {
  source = "./modules/additional-user-access"

  project_id             = module.project_factory.project_id
  domain                 = var.domain
  additional_user_access = var.additional_user_access
  clan_gsuite_group      = var.clan_gsuite_group
  env_name               = var.env_name
  create_custom_roles    = var.create_custom_roles
  pubsub_sa              = local.pubsub_sa
  pubsub_api_enabled     = contains(module.project_factory.enabled_apis, "pubsub.googleapis.com")
}

module "service_accounts" {
  source = "./modules/service-account"

  create_service_account = var.create_sa
  project_id             = module.project_factory.project_id
  service_accounts       = var.service_accounts
}

module "gke_resources" {
  source = "./modules/gke-resources"

  project_type       = var.project_type
  project_id         = module.project_factory.project_id
  cluster_project_id = var.parent_project_id
  services           = var.services
  gke_ca_certificate = var.gke_ca_certificate
  gke_host           = var.gke_host
  cicd_service       = local.ci_cd_sa_email
  sa_depends_on      = module.services_sa.email
}

module "pact_broker" {
  source = "./modules/pact-broker"

  pact_project_id        = var.pact_project_id
  project_id             = module.project_factory.project_id
  pactbroker_user_secret = var.pactbroker_user_secret
  pactbroker_pass_secret = var.pactbroker_pass_secret
  create_pact_secrets    = var.create_pact_secrets
  env_name               = var.env_name
}
