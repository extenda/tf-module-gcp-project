module "project_factory" {
  source  = "terraform-google-modules/project-factory/google"
  version = "6.1"

  name              = var.name
  random_project_id = var.random_project_id

  default_service_account = var.default_service_account

  org_id          = var.org_id
  folder_id       = var.folder_id
  billing_account = var.billing_account

  bucket_name     = "tf-state-${var.tribe}-${var.clan}-${var.environment}-${var.name}"
  bucket_location = "EU"
  bucket_project  = var.name

  activate_apis = var.activate_apis
}

module "ci_cd_sa" {
  source = "../service-account"

  create_service_account = var.create_ci_cd_service_account

  project_id   = module.project_factory.project_id
  account_id   = "ci-cd-pipeline"
  display_name = "CI/CD Service Account"
  iam_roles    = var.ci_cd_sa_iam_roles
}

module "cloudrun_sa" {
  source = "../service-account"

  create_service_account = var.create_cloudrun_service_account

  project_id   = module.project_factory.project_id
  account_id   = "cloudrun-runtime"
  display_name = "Cloud Run Runtime Service Account"
  iam_roles    = var.cloudrun_sa_iam_roles
}

module "secret_manager_sa" {
  source = "../service-account"

  create_service_account = var.create_secret_manager_service_account

  project_id   = module.project_factory.project_id
  account_id   = "secret-accessor"
  display_name = "Secret Manager Accessor Service Account"

  iam_roles = {
    r0 : "roles/secretmanager.secretAccessor"
  }
}
