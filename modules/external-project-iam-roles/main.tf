resource "google_project_iam_member" "parent_project_roles" {
  for_each = (var.parent_project_id != "") && (var.service_account_exists) ? toset(var.parent_project_iam_roles) : toset([])

  project = var.parent_project_id
  role    = each.key
  member  = "serviceAccount:${var.service_account}"
}

resource "google_project_iam_member" "gcr_project_roles" {
  for_each = (var.gcr_project_id != "") && (var.service_account_exists) ? toset(var.gcr_project_iam_roles) : toset([])

  project = var.gcr_project_id
  role    = each.key
  member  = "serviceAccount:${var.service_account}"
}

resource "google_project_iam_member" "gke_parent_roles" {
  for_each = (var.parent_project_id != "") && (var.gke_service_account != "") ? toset(var.gke_parent_iam_roles) : toset([])

  project = var.parent_project_id
  role    = each.key
  member  = "serviceAccount:${var.gke_service_account}"
}

resource "google_project_iam_member" "gke_gcr_roles" {
  for_each = (var.parent_project_id != "") && (var.gke_service_account != "") ? toset(var.gke_gcr_iam_roles) : toset([])

  project = var.gcr_project_id
  role    = each.key
  member  = "serviceAccount:${var.gke_service_account}"
}

resource "google_project_iam_member" "dns_project_roles" {
  for_each = var.dns_project_id != "" && (var.service_account_exists) ? toset(var.dns_project_iam_roles) : toset([])

  project = var.dns_project_id
  role    = each.key
  member  = "serviceAccount:${var.service_account}"
}
