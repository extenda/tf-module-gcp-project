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

resource "google_project_iam_member" "project_roles" {
  for_each = {
    for service in local.service_roles :
    "${service.service_key}.${service.role_key}" => service
    if var.create_service_account == true && var.create_service_group == false
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
  service_account_id = "projects/${var.project_id}/serviceAccounts/${var.services[each.value].name}@${var.project_id}.iam.gserviceaccount.com"
  depends_on = [google_service_account.sa]
}

resource "gsuite_group" "service_group" {
  for_each = {
    for key, value in var.services :
    key => key
    if var.create_service_account == true && var.create_service_group == true
  }
  email       = "${var.service_group_name}-${var.services[each.value].name}@${var.domain}"
  name        = "${var.service_group_name}-${var.services[each.value].name}"
  description = "${var.services[each.value].name} GSuite Group"

  depends_on = [google_service_account.sa]
}


resource "gsuite_group_member" "service_account_sa_group_member" {
  for_each = {
    for key, value in var.services :
    key => key
    if var.create_service_account == true && var.create_service_group == true
  }
  group = "${var.service_group_name}-${var.services[each.value].name}@${var.domain}"
  email = google_service_account.sa[each.value].email
  role  = "MEMBER"

  depends_on = [gsuite_group.service_group]
}

resource "gsuite_group_member" "clan_group_member" {
  for_each = {
    for key, value in var.services :
    key => key
    if var.create_service_account == true && var.create_service_group == true && var.env_name == "staging"
  }
  group = "${var.service_group_name}-${var.services[each.value].name}@${var.domain}"
  email = "${var.clan_gsuite_group}@${var.domain}"
  role  = "MEMBER"

  depends_on = [gsuite_group.service_group]
}


resource "google_project_iam_member" "service_group_roles" {
  for_each = {
    for service in local.service_roles :
    "${service.service_key}.${service.role_key}" => service
    if var.create_service_account == true && var.create_service_group == true
  }
  project = var.project_id
  role    = each.value.role_id
  member  = "group:${var.service_group_name}-${var.services[each.value.service_key].name}@${var.domain}"

  depends_on = [gsuite_group.service_group]
}
