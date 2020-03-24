locals {
  service_roles = flatten([for service_key, service in var.services : [
    for role_key, role in service.iam_roles : {
      service_key = service_key
      role_key    = role_key
      service_id  = google_service_account.sa[service_key].account_id
      role_id     = role
    }
    ]
  ])
}

resource "google_service_account" "sa" {
  # for_each = var.create_service_account == true ? {for key, value in var.services: key => key} : {}
  for_each = {
    for key, value in var.services :
    key => key
    if var.create_service_account == true
  }
  account_id   = var.services[each.value].name
  display_name = "${var.services[each.value].name} Service Account"
  project      = var.project_id
}

resource "google_project_iam_member" "project-roles" {
  # for_each = var.create_service_account == true ? {for service in local.service_roles: "${service.service_key}.${service.role_key}" => service} : {}
  for_each = {
    for service in local.service_roles :
    "${service.service_key}.${service.role_key}" => service
    if var.create_service_account == true
  }
  project = var.project_id
  role    = each.value.role_id
  member  = "serviceAccount:${google_service_account.sa[each.value.service_key].email}"

  depends_on = [google_service_account.sa]
}

resource "google_service_account_key" "key_json" {
  # for_each = var.create_service_account == true ? {for key, value in var.services: key => key} : {}
  for_each = {
    for key, value in var.services :
    key => key
    if var.create_service_account == true
  }
  service_account_id = var.services[each.value].name

  depends_on = [google_service_account.sa]
}
