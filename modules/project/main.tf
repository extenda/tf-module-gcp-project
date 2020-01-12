module "project_factory" {
  source  = "terraform-google-modules/project-factory/google"
  version = "6.1"

  name              = var.name
  random_project_id = true

  default_service_account = "deprivilege"

  org_id          = var.org_id
  folder_id       = var.folder_id
  billing_account = var.billing_account

  activate_apis = var.activate_apis
}

module "ci_cd_sa" {
  source = "../ci-cd-service-account"

  create_ci_cd_service_account = var.create_ci_cd_service_account

  project = module.project_factory.project_name
  iam_roles = var.ci_cd_sa_iam_roles
}
