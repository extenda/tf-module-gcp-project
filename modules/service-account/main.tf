locals {
 association_list =  flatten([
    for service, roles in var.services : [
      for role in roles : {
        "${service}-${role}" = {
          "role" = role
          "service" = service
          }
      }
    ]
 ])
 
association_map = { for item in local.association_list: 
     keys(item)[0] => values(item)[0]
   }
}

resource "google_service_account" "sa" {
  for_each      = local.association_map
  account_id    = each.value.service
  display_name  = var.display_name
  project       = var.project_id
}

resource "google_project_iam_member" "project-roles" {
  for_each = local.association_map
  project  = var.project_id
  role     = each.value.role

  member = "serviceAccount:${google_service_account.sa[each.key].email}"
}