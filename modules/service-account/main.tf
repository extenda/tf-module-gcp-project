locals {
  service_roles = flatten([for service_key, service in var.services : [
    for role_key, role in distinct(concat(service.iam_roles, var.common_iam_roles)) : {
      name        = service.name
      role        = role
      service_id  = var.create_service_account == true ? google_service_account.sa[service.name].account_id : ""
    }
    ]
  ])
}

resource "google_service_account" "sa" {
  for_each = {
    for service in var.services :
    service.name => service
    if var.create_service_account == true
  }
  account_id   = each.key
  display_name = "${each.key} Service Account"
  project      = var.project_id
}

resource "google_project_iam_member" "project_roles" {
  for_each = {
    for service in local.service_roles :
    "${service.name}.${service.role}" => service
    if var.create_service_account == true && var.create_service_group == false
  }
  project = var.project_id
  role    = each.value.role
  member  = "serviceAccount:${google_service_account.sa[each.value.name].email}"

  depends_on = [google_service_account.sa]
}

resource "google_service_account_key" "key_json" {
  for_each = {
    for service in var.services :
    service.name => service
    if var.create_service_account == true
  }
  service_account_id = "projects/${var.project_id}/serviceAccounts/${each.key}@${var.project_id}.iam.gserviceaccount.com"
  depends_on = [google_service_account.sa]
}

resource "gsuite_group" "service_group" {
  for_each = {
    for service in var.services :
    service.name => service
    if var.create_service_account == true && var.create_service_group == true
  }
  email       = "${var.service_group_name}-${each.key}@${var.domain}"
  name        = "${var.service_group_name}-${each.key}"
  description = "${each.key} GSuite Group"

  depends_on = [google_service_account.sa]
}


resource "gsuite_group_member" "service_account_sa_group_member" {
  for_each = {
    for service in var.services :
    service.name => service
    if var.create_service_account == true && var.create_service_group == true
  }
  group = "${var.service_group_name}-${each.key}@${var.domain}"
  email = google_service_account.sa[each.key].email
  role  = "MEMBER"

  depends_on = [gsuite_group.service_group]
}

resource "gsuite_group_member" "clan_group_member" {
  for_each = {
    for service in var.services :
    service.name => service
    if var.create_service_account == true && var.create_service_group == true && var.env_name == "staging"
  }
  group = "${var.service_group_name}-${each.key}@${var.domain}"
  email = "${var.clan_gsuite_group}@${var.domain}"
  role  = "MEMBER"

  depends_on = [gsuite_group.service_group]
}


resource "google_project_iam_member" "service_group_roles" {
  for_each = {
    for service in local.service_roles :
    "${service.name}.${service.role}" => service
    if var.create_service_account == true && var.create_service_group == true
  }
  project = var.project_id
  role    = each.value.role
  member  = "group:${var.service_group_name}-${each.value.name}@${var.domain}"

  depends_on = [gsuite_group.service_group]
}
