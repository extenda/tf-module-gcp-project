locals {
  ci_cd_sa_email = var.create_ci_cd_service_account ? module.ci_cd_sa.email[var.ci_cd_sa[0].name] : "mock@nonexisting"
}

module "project_factory" {
  source  = "terraform-google-modules/project-factory/google"
  version = "6.1"

  name              = var.name
  random_project_id = var.random_project_id

  default_service_account = var.default_service_account

  org_id          = var.org_id
  folder_id       = var.folder_id
  billing_account = var.billing_account

  bucket_name     = var.bucket_name
  bucket_location = "EU"
  bucket_project  = var.name

  activate_apis = var.activate_apis

  shared_vpc         = var.shared_vpc
  shared_vpc_subnets = var.shared_vpc_subnets
}

module "ci_cd_sa" {
  source = "../service-account"

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
  source = "../service-account"

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
  source = "../service-account"

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
  source = "../service-account"

  create_service_account = var.create_service_sa
  create_service_group   = var.create_services_group
  service_group_name     = var.service_group_name
  clan_gsuite_group      = var.clan_gsuite_group

  project_id = module.project_factory.project_id
  services   = var.services
  domain     = var.domain
  env_name   = var.env_name
}

module "parent_project_iam" {
  source = "../external-project-iam"

  service_account          = local.ci_cd_sa_email
  parent_project_id        = var.parent_project_id
  parent_project_iam_roles = var.parent_project_iam_roles

  gcr_project_id        = var.gcr_project_id
  gcr_project_iam_roles = var.gcr_project_iam_roles
  gke_service_account   = var.gke_service_account
  gke_parent_iam_roles  = var.gke_parent_iam_roles
  gke_gcr_iam_roles     = var.gke_gcr_iam_roles
}
