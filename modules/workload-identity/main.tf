locals {
  service_emails = {
    for service in var.services :
    service.name => "${service.name}@${var.project_id}.iam.gserviceaccount.com"
  }
}

resource "google_service_account_iam_member" "workload" {
  for_each = var.cluster_project_id != "" ? local.service_emails : {}
  service_account_id = "projects/${var.project_id}/serviceAccounts/${each.value}"
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.cluster_project_id}.svc.id.goog[${each.key}/${var.ksa_name}]"
  depends_on         = [var.sa_depends_on]
}
