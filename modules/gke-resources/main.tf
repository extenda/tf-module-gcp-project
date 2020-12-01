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

resource "kubernetes_default_service_account" "service_workload_identity" {
  for_each = var.cluster_project_id != "" ? local.service_name : {}
  metadata {
    annotations = {
      "iam.gke.io/gcp-service-account" = "${each.key}@${var.project_id}.iam.gserviceaccount.com"
    }
    namespace = each.key
  }
}

resource "kubernetes_role" "ci_cd_namespace_admin_role" {
  for_each = var.cluster_project_id != "" ? local.service_name : {}

  metadata {
    namespace = each.key
    name = "${each.key}-admin"
  }
  rule {
    api_groups  = ["*"]
    resources   = ["*"]
    verbs       = ["*"]
  }
}

resource "kubernetes_cluster_role" "ci_cd_cluster_role" {

  metadata {
    name = "cicd-pipeline-cluster-role"
  }
  rule {
    api_groups  = [""]
    resources   = ["persistentvolumes"]
    verbs       = ["*"]
  }
}

resource "kubernetes_cluster_role_binding" "ci_cd_cluster_role_binding" {

  metadata {
    name = "${var.cicd_service}"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cicd-pipeline-cluster-role"
  }
  subject {
    kind      = "User"
    name      = "${var.cicd_service}"
    api_group = "rbac.authorization.k8s.io"
  }
}

resource "kubernetes_role_binding" "ci_cd_namespace_admin_role_binding" {
  for_each = var.cluster_project_id != "" ? local.service_name : {}

  metadata {
    namespace = each.key
    name = "${each.key}-admin-binding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "${each.key}-admin"
  }
  subject {
    kind      = "User"
    name      = "${var.cicd_service}"
    api_group = "rbac.authorization.k8s.io"
  }
}