resource "google_service_account" "ci_cd" {
  count = var.create_ci_cd_service_account ? 1 : 0

  account_id   = "ci-cd-pipeline"
  display_name = "CI/CD Service Account"
  project      = var.project
}

resource "google_project_iam_member" "project" {
  count = var.create_ci_cd_service_account ? 1 : 0

  for_each = var.iam_roles
  project  = var.project
  role     = each.value
  member   = "serviceAccount:${google_service_account.ci_cd.email}"
}

resource "google_service_account_key" "key_json" {
  count = var.create_ci_cd_service_account ? 1 : 0
  
  service_account_id = google_service_account.ci_cd.id
}
