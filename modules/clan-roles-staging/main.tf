resource "google_project_iam_member" "clan_group_roles" {
  for_each = var.env_name == "staging" ? toset(var.clan_roles) : toset([])
  project  = var.project_id
  role     = each.value
  member   = "group:${var.clan_gsuite_group}@${var.domain}"
}
