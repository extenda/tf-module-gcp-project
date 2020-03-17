resource "google_service_account" "sa" {
  for_each = {
        for key, value in var.services:
        key => key
  }
  account_id    =  var.services[each.value].name
  display_name  = var.display_name
  project       = var.project_id
}

resource "google_project_iam_member" "project" {
  # for_each = length(google_service_account.sa) > 0 ? var.iam_roles : {}
  for_each = {
        for key, value in var.services:
        key => key
  }
  project  = var.project_id
  role     = var.services[each.value].iam_roles
  member   = "serviceAccount:${google_service_account.sa[0].email}"

  depends_on = [google_service_account.sa[0]]
}

resource "google_service_account_key" "key_json" {
  count = var.create_service_account ? 1 : 0

  service_account_id = google_service_account.sa[0].id

  depends_on = [google_service_account.sa[0]]
}
