resource "google_service_account" "sa" {
  count = var.create_service_account ? 1 : 0

  account_id   = "ci-cd-pipeline"
  display_name = "CI/CD Service Account"
  project      = var.project_id
}

resource "google_project_iam_member" "project" {
  for_each = var.iam_roles
  project  = var.project_id
  role     = each.value
  member   = "serviceAccount:${google_service_account.sa[0].email}"

  depends_on = [google_service_account.sa[0]]
}

resource "google_service_account_key" "key_json" {
  service_account_id = google_service_account.sa[0].id

  depends_on = [google_service_account.sa[0]]
}
