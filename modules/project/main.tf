module "project_factory" {
  source  = "terraform-google-modules/project-factory/google"
  version = "6.1"

  name              = var.name
  random_project_id = var.random_project_id

  default_service_account = var.default_service_account

  org_id          = var.org_id
  folder_id       = var.folder_id
  billing_account = var.billing_account

  activate_apis = var.activate_apis
}

module "ci_cd_sa" {
  source = "../ci-cd-service-account"

  create_service_account = var.create_ci_cd_service_account

  project_id = module.project_factory.project_id
  iam_roles  = var.ci_cd_sa_iam_roles
}

module "cloudrun_sa" {
  source = "../cloud-run-service-account"

  create_service_account = var.create_cloudrun_service_account

  project_id = module.project_factory.project_id
  iam_roles  = var.cloudrun_sa_iam_roles
}
