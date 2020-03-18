locals {
  names                 = toset(var.names)
  name_role_pairs       = setproduct(local.names, toset(var.project_roles))
  project_roles_map_data = zipmap(
    [for pair in local.name_role_pairs : "${pair[0]}-${pair[1]}"],
    [for pair in local.name_role_pairs : {
      name = pair[0]
      role = pair[1]
    }]
  )
}

resource "google_service_account" "sa" {
  for_each     = local.names
  account_id    = lower(each.value)
  display_name  = "${lower(each.value)} service account"
  project       = var.project_id
}

resource "google_project_iam_member" "project-roles" {
  for_each = local.project_roles_map_data

  project = var.project_id

  role = element(
    split(
      "=>",
      each.value.role
    ),
    1,
  )

  member = "serviceAccount:${google_service_account.sa[each.value.name].email}"
}
