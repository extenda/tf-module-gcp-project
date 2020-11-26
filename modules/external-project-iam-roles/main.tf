locals {
  service_roles = flatten([for service_key, service in var.services : [
    for role_key, role in var.common_iam_roles : {
      name = service.name
      role = role
    }
    ]
  ])
}

resource "google_project_iam_member" "parent_project_service_roles" {
  for_each = {
    for service in local.service_roles :
    "${service.name}.${service.role}" => service
    if var.service_account_exists == true && var.parent_project_id != ""
  }
  project = var.parent_project_id
  role    = each.value.role
  member  = "serviceAccount:${each.value.name}@${var.project_id}.iam.gserviceaccount.com"

  depends_on = [var.sa_depends_on]
}

resource "google_project_iam_member" "parent_project_roles" {
  for_each = (var.parent_project_id != "") && (var.service_account_exists) ? toset(var.parent_project_iam_roles) : toset([])

  project = var.parent_project_id
  role    = each.key
  member  = "serviceAccount:${var.service_account}"
}

resource "google_project_iam_member" "parent_project_gke_role" {
  project = var.parent_project_id
  role    = google_project_iam_custom_role.gke_custom_role.id
  member  = "serviceAccount:${var.service_account}"

  depends_on = [google_project_iam_custom_role.gke_custom_role]
}

resource "google_project_iam_member" "gcr_project_roles" {
  for_each = (var.gcr_project_id != "") && (var.service_account_exists) ? toset(var.gcr_project_iam_roles) : toset([])

  project = var.gcr_project_id
  role    = each.key
  member  = "serviceAccount:${var.service_account}"
}

resource "google_project_iam_member" "dns_project_roles" {
  for_each = var.dns_project_id != "" && (var.service_account_exists) ? toset(var.dns_project_iam_roles) : toset([])

  project = var.dns_project_id
  role    = each.key
  member  = "serviceAccount:${var.service_account}"
}

resource "google_project_iam_custom_role" "gke_custom_role" {
  project     = var.parent_project_id
  role_id     = "cicd.gke.manager"
  title       = "CI/CD GKE manager role"
  description = "Custom role for minimal access to GKE"
  permissions = ["container.apiServices.get", "container.apiServices.list", "container.clusters.get", "container.clusters.getCredentials"]
}
