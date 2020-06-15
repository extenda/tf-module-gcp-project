locals {
  ci_cd_sa_email = var.create_ci_cd_service_account ? module.ci_cd_sa.email[var.ci_cd_sa[0].name] : ""
  secret_suffix  = var.env_name == "" ? "" : "_${upper(var.env_name)}"
}

module "project_factory" {
  source  = "terraform-google-modules/project-factory/google"
  version = "8.0"

  name              = var.name
  random_project_id = var.random_project_id

  default_service_account = var.default_service_account
  skip_gcloud_download    = true

  org_id          = var.org_id
  folder_id       = var.folder_id
  billing_account = var.billing_account

  bucket_name     = var.bucket_name
  bucket_location = "EU"
  bucket_project  = var.name

  activate_apis = var.activate_apis
  labels        = var.labels

  shared_vpc         = var.shared_vpc
  shared_vpc_subnets = var.shared_vpc_subnets
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
}

module "service_accounts" {
  source = "./modules/service-account"

  create_service_account = var.create_sa
  project_id             = module.project_factory.project_id
  service_accounts       = var.service_accounts
}