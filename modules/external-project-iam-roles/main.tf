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
  count = var.project_type == "clan_project" ? 1 : 0

  project = var.parent_project_id
  role    = "projects/${var.parent_project_id}/roles/cicd.gke.manager"
  member  = "serviceAccount:${var.service_account}"

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
  count = var.project_type == "tribe_project" ? 1 : 0
  
  project     = var.project_id
  role_id     = "cicd.gke.manager"
  title       = "CI/CD GKE manager role"
  description = "Custom role for minimal access to GKE"
  permissions = ["container.apiServices.get", "container.apiServices.list", "container.clusters.get", "container.clusters.getCredentials", "container.clusters.list"]
}

resource "google_project_iam_member" "token_creator_project_role" {
  count = var.env_name == "staging" ? 1 : 0

  project = var.project_id
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:${var.service_account}"
}
