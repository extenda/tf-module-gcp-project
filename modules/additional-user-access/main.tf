locals {
  group_roles = flatten([for group_key, group in var.additional_user_access : [
    for role_key, role in group.iam_roles : {
      name = group.name
      role = role
    }
    ]
  ])
  group_members = flatten([for group_key, group in var.additional_user_access : [
    for member_key, member in group.members : {
      name   = group.name
      member = member
    }
  ]
  ])
}

resource "gsuite_group" "access_group" {
  for_each = {
    for group in var.additional_user_access :
    group.name => group
    if var.env_name == "prod"
  }
  email       = "${var.clan_gsuite_group}-prod-${each.key}@${var.domain}"
  name        = "${var.clan_gsuite_group}-prod-${each.key}"
  description = "${each.key} GSuite Group"
}


resource "gsuite_group_member" "access_group_member" {
  for_each = {
    for group in local.group_members :
    "${group.name}/${group.member}" => group
    if var.env_name == "prod"
  }
  group = "${var.clan_gsuite_group}-prod-${each.value.name}@${var.domain}"
  email = each.value.member
  role  = "MEMBER"

  depends_on = [gsuite_group.access_group]
}

resource "google_project_iam_member" "local_access_group_roles" {
  for_each = {
    for group in local.group_roles :
    "${group.name}.${group.role}" => group
    if var.env_name == "prod"
  }
  project = var.project_id
  role    = each.value.role
  member  = "group:${var.clan_gsuite_group}-prod-${each.value.name}@${var.domain}"

  depends_on = [gsuite_group.access_group]
}

resource "google_project_iam_custom_role" "cs_custom_role" {
  count = var.create_custom_roles ? 1 : 0

  project     = var.project_id
  role_id     = "cloudschedulerrole"
  title       = "Cloud Scheduler role"
  description = "The role for the Cloud Scheduler"
  permissions = ["appengine.applications.create", "serviceusage.services.enable", "cloudscheduler.jobs.run", "cloudscheduler.jobs.fullView"]
}

resource "google_project_iam_member" "local_scheduler_role" {
  count = var.create_custom_roles && var.clan_gsuite_group != "" ? 1 : 0

  project = var.project_id
  role    = google_project_iam_custom_role.cs_custom_role[0].name
  member  = "group:${var.clan_gsuite_group}@${var.domain}"

  depends_on = [google_project_iam_custom_role.cs_custom_role]
}
