locals {
  service_roles = flatten([for service_key, service in var.services : [
    for role_key, role in distinct(service.iam_roles) : {
      name        = service.name
      role        = role
      service_id  = var.create_service_account == true ? google_service_account.sa[service.name].account_id : ""
    }
    ]
  ])
}


resource "google_project_iam_custom_role" "common_custom_role" {
  count = var.create_service_account == true && var.ci_cd_account == false && var.create_service_group == true ? 1 : 0

  project     = var.project_id
  role_id     = "common.services"
  title       = "Custom role for each service"
  description = "Custom role with common permissions for each deployed service"
  permissions = [
    "monitoring.metricDescriptors.create", "monitoring.metricDescriptors.get", "monitoring.metricDescriptors.list", "monitoring.monitoredResourceDescriptors.get",
    "monitoring.monitoredResourceDescriptors.list", "monitoring.timeSeries.create", "logging.logEntries.create", "cloudnotifications.activities.list", "monitoring.alertPolicies.get",
    "monitoring.alertPolicies.list", "monitoring.dashboards.get", "monitoring.dashboards.list", "monitoring.groups.get", "monitoring.groups.list",
    "monitoring.metricDescriptors.get", "monitoring.metricDescriptors.list", "monitoring.monitoredResourceDescriptors.get", "monitoring.monitoredResourceDescriptors.list", "monitoring.notificationChannelDescriptors.get",
    "monitoring.notificationChannelDescriptors.list", "monitoring.notificationChannels.get", "monitoring.notificationChannels.list", "monitoring.publicWidgets.get", "monitoring.publicWidgets.list",
    "monitoring.services.get", "monitoring.services.list", "monitoring.slos.get", "monitoring.slos.list", "monitoring.timeSeries.list",
    "monitoring.uptimeCheckConfigs.get", "monitoring.uptimeCheckConfigs.list", "opsconfigmonitoring.resourceMetadata.list", "resourcemanager.projects.get",
    "stackdriver.projects.get", "cloudtrace.traces.patch", "resourcemanager.projects.get", "secretmanager.versions.access"
  ]
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
    if var.create_service_account == true && var.create_service_group == false || var.ci_cd_account == true
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
    if var.create_service_account == true && var.create_service_group == true && var.ci_cd_account == false
  }
  group = "${var.service_group_name}-${each.key}@${var.domain}"
  email = google_service_account.sa[each.key].email
  role  = "MEMBER"

  depends_on = [gsuite_group.service_group]
}

resource "gsuite_group_member" "service_account_ci_cd_group_member" {
  for_each = {
    for service in var.services :
    service.name => service
    if var.ci_cd_account == true
  }
  group = "${var.service_group_name}-${each.key}@${var.domain}"
  email = google_service_account.sa[each.key].email
  role  = "MEMBER"
}

resource "gsuite_group_member" "clan_group_member" {
  for_each = {
    for service in var.services :
    service.name => service
    if var.create_service_account == true && var.create_service_group == true && var.env_name == "staging" && var.ci_cd_account == false
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
    if var.create_service_account == true && var.create_service_group == true && var.ci_cd_account == false
  }
  project = var.project_id
  role    = each.value.role
  member  = "group:${var.service_group_name}-${each.value.name}@${var.domain}"

  depends_on = [gsuite_group.service_group]
}

resource "google_project_iam_member" "service_group_roles_common" {
   for_each = {
    for service in var.services :
    service.name => service
    if var.create_service_account == true && var.create_service_group == true && var.ci_cd_account == false
  }
  project = var.project_id
  role    = google_project_iam_custom_role.common_custom_role[0].name
  member  = "group:${var.service_group_name}-${each.key}@${var.domain}"

  depends_on = [gsuite_group.service_group, google_project_iam_custom_role.common_custom_role]
}

resource "gsuite_group" "service_clan_group" {
  count = var.create_service_account == true && var.ci_cd_account == false && var.create_service_group == true ? 1 : 0
  email       = "${var.clan_gsuite_group}-services@${var.domain}"
  name        = "${var.clan_gsuite_group}-services"
  description = "Clan services GSuite Group"
  depends_on = [google_service_account.sa]
}

resource "gsuite_group_member" "clan_group_services_member_staging" {
  for_each = {
    for service in var.services :
    service.name => service
    if var.create_service_account == true && var.create_service_group == true && var.env_name == "staging" && var.ci_cd_account == false
  }
  group = "${var.clan_gsuite_group}-services@${var.domain}"
  email = google_service_account.sa[each.key].email
  role  = "MEMBER"
  depends_on = [gsuite_group.service_clan_group]
}

resource "gsuite_group_member" "clan_group_services_member_prod" {
  for_each = {
    for service in var.services :
    service.name => service
    if var.create_service_account == true && var.create_service_group == true && var.env_name == "prod" && var.ci_cd_account == false
  }
  group = "${var.clan_gsuite_group}-services@${var.domain}"
  email = google_service_account.sa[each.key].email
  role  = "MEMBER"
  depends_on = [gsuite_group.service_clan_group]
}

resource "google_project_iam_member" "extenda_storage_viewer" {
  count = var.create_service_account == true && var.ci_cd_account == false && var.create_service_group == true ? 1 : 0

  project = "extenda"
  role    = "roles/storage.objectViewer"
  member  = "group:${var.clan_gsuite_group}-services@${var.domain}"
  depends_on = [gsuite_group.service_clan_group]
}
