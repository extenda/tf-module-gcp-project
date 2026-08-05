locals {
  service_account_roles = flatten([for sa_key, sa in var.service_accounts : [
    for role_key, role in sa.iam_roles : {
      name       = sa.name
      role       = role
    }
    ]
  ])

  # Flatten SA-level IAM bindings for resource-level permissions on target service accounts
  sa_iam_bindings = flatten([for sa in var.service_accounts : [
    for binding in coalesce(sa.sa_iam_bindings, []) : {
      sa_name     = sa.name
      target_sa   = binding.target_sa
      role        = binding.role
      condition   = binding.condition
      binding_key = "${sa.name}.${binding.target_sa}.${binding.role}"
    }
  ]])
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
    if var.create_service_account == true
  }
  project = var.project_id
  role    = each.value.role
  member  = "serviceAccount:${google_service_account.service_acc[each.value.name].email}"

  depends_on = [google_service_account.service_acc]
}

# SA-level IAM bindings: grant roles ON a target service account (not at project level)
# This enables scenarios like: SA-A can generate tokens ONLY for SA-B (not all SAs in project)
resource "google_service_account_iam_member" "sa_level_bindings" {
  for_each = {
    for binding in local.sa_iam_bindings :
    binding.binding_key => binding
    if var.create_service_account == true
  }

  service_account_id = "projects/${var.project_id}/serviceAccounts/${each.value.target_sa}@${var.project_id}.iam.gserviceaccount.com"
  role               = each.value.role
  member             = "serviceAccount:${google_service_account.service_acc[each.value.sa_name].email}"

  dynamic "condition" {
    for_each = each.value.condition != null ? [each.value.condition] : []
    content {
      title       = condition.value.title
      description = lookup(condition.value, "description", null)
      expression  = condition.value.expression
    }
  }

  depends_on = [google_service_account.service_acc]
}

resource "google_service_account_key" "key_json" {
  for_each = {
    for sa in var.service_accounts :
    sa.name => sa
    if var.create_service_account == true && var.create_service_account_keys == true
  }
  service_account_id = "projects/${var.project_id}/serviceAccounts/${each.key}@${var.project_id}.iam.gserviceaccount.com"
  
  depends_on = [google_service_account.service_acc]
}
