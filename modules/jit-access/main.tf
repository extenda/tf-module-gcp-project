locals {
  group_roles = flatten([for group_key, group_name in var.jit_access : [
    for role_key, role in distinct(group_name.iam_roles) : {
      group = group_name.group
      role  = role
    }
  ]])
}

resource "google_project_iam_member" "jit_binding" {
  for_each = {
    for group_name in local.group_roles :
    "${group_name.group}.${group_name.role}" => group_name
    if var.create_jit_access == true
  }
  project = var.project_id
  role    = each.value.role
  member  = "group:${each.value.group}"

  condition {
    title       = "Eligible for JIT access"
    expression  = "has({}.jitAccessConstraint)"
  }
}
