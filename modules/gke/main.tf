locals {
  service_name = {
    for service in var.services :
    service.name => service.name
  }
}


resource "kubernetes_namespace" "service_namespace" {
  for_each = var.cluster_project_id != "" ? local.service_name : {}
  metadata {
    name = each.key
  }
  lifecycle {
    ignore_changes = [
      metadata[0].labels
    ]
  }
}
