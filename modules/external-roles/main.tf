locals {
  service_roles = flatten([
    for service_account, projects_map in var.roles_map : [
      for project_id, roles_list in projects_map : [
        for role_index, role in roles_list : {
          service_account = service_account,
          project_id      = project_id,
          role            = role,
        }
      ]
    ]
  ])
}

resource "google_project_iam_member" "external_roles" {
  for_each = {
    for i in local.service_roles :
    "${i.service_account}:${i.project_id}:${i.role}" => i
    if(i.service_account != "") && (i.project_id != "")
    && ((length(regexall("^.+@.+.iam.gserviceaccount.com$", i.service_account)) > 0))
  }
  project = each.value.project_id
  role    = each.value.role
  member = (
    length(regexall("^.+@.+.iam.gserviceaccount.com$", each.value.service_account)) > 0
  ) ? "serviceAccount:${each.value.service_account}" : "serviceAccount:${each.value.service_account}@${var.project_id}.iam.gserviceaccount.com"

  depends_on = [var.sa_depends_on]
}
