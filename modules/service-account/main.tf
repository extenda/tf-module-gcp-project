locals {
  service_account_roles = flatten([for sa_key, sa in var.service_accounts : [
    for role_key, role in service_accounts.iam_roles : {
      name       = sa.name
      role       = role
      service_id = var.create_service_account == true ? google_service_account.service_acc[sa.name].account_id : ""
    }
    ]
  ])
}

resource "google_service_account" "service_acc" {
  for_each = {
    for sa in var.service_accounts :
    sa.name => sa
    if var.create_service_account == true
  }
  account_id   = each.key
  display_name = "${each.key} Service Account"
  project      = var.project_id
}

resource "google_project_iam_member" "project_roles" {
  for_each = {
    for sa in local.service_account_roles :
    "${sa.name}.${sa.role}" => sa
  }
  project = var.project_id
  role    = each.value.role
  member  = "serviceAccount:${google_service_account.service_acc[each.value.name].email}"

  depends_on = [google_service_account.service_acc]
}

resource "google_service_account_key" "key_json" {
  for_each = {
    for sa in var.service_accounts :
    sa.name => sa
    if var.create_service_account == true
  }
  service_account_id = "projects/${var.project_id}/serviceAccounts/${each.key}@${var.project_id}.iam.gserviceaccount.com"
  
  depends_on = [google_service_account.service_acc]
}
