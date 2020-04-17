resource "google_project_iam_member" "project_roles" {
  for_each = var.parent_project_id != "" ? toset(var.parent_project_iam_roles) : toset([])

  project = var.parent_project_id
  role    = each.key
  member  = "serviceAccount:${var.service_account}"
}
