locals {
  service_roles = flatten([for service_key, service in var.services : [
    for role_key, role in service.iam_roles : {
      service_key = service_key
      role_key    = role_key
      service_id  = var.create_service_account == true ? google_service_account.sa[service_key].account_id : ""
      role_id     = role
    }
    ]
  ])
}

resource "google_service_account" "sa" {
  for_each = {
    for key, value in var.services :
    key => key
    if var.create_service_account == true
  }
  account_id   = var.services[each.value].name
  display_name = "${var.services[each.value].name} Service Account"
  project      = var.project_id
}


resource "gsuite_group" "service_group" {
  for_each = {
    for key, value in var.services :
    key => key
    if var.create_service_account == true
  }
  email       = "${var.services[each.value].name}@extenda.io"
  name        = "${var.services[each.value].name} group"
  description = "Service GSuite Group"
}


resource "gsuite_group_member" "service_account_sa_group_member" {
  for_each = {
    for service in local.service_roles :
      "${service.service_key}.${service.role_key}" => service
      if var.create_service_account == true
  }
  #group = "${var.services[each.value].name}@extenda.io"
  group = "${var.services[each.value.service_key].name}@extenda.io"
  email = "serviceAccount:${google_service_account.sa[each.value.service_key].email}"
  role  = "MEMBER"
}


resource "google_project_iam_member" "project-roles" {
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
  for_each = {
    for key, value in var.services :
    key => key
    if var.create_service_account == true
  }
  service_account_id = var.services[each.value].name

  depends_on = [google_service_account.sa]
}
