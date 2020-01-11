resource "google_service_account" "ci_cd" {
  count = var.create_ci_cd_service_account ? 1 : 0

  account_id   = "ci-cd-pipeline"
  display_name = "CI/CD Service Account"
  project      = var.project
}

resource "google_project_iam_member" "project" {
  for_each = var.iam_roles
  project  = var.project
  role     = each.value
  member   = "serviceAccount:${google_service_account.ci_cd[0].email}"

  depends_on = [google_service_account.ci_cd[0]]
}

resource "google_service_account_key" "key_json" {
  service_account_id = google_service_account.ci_cd[0].id

  depends_on = [google_service_account.ci_cd[0]]
}
