resource "google_service_account" "sa" {
  for_each = {
        for key, value in var.services:
        key => key
  }
  account_id    = var.services[each.value].name
  display_name  = var.display_name
  project       = var.project_id
}

resource "google_project_iam_member" "project-roles" {
  for_each = {
        for key, value in var.services:
        key => key
  }
  project = var.project_id

  role = var.services[each.value].iam_roles[0]

  member = "serviceAccount:${google_service_account.sa[0].email}"
}
