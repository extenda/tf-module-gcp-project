locals {
  service_name = {
    for service in var.services :
    service.name => service.name
  }

  service_emails = {
    for service in var.services :
    service.name => "${service.name}@${var.project_id}.iam.gserviceaccount.com"
  }
}

resource "google_service_account_iam_member" "workload" {
  for_each = var.project_type == "clan_project" ? local.service_emails : {}

  service_account_id = "projects/${var.project_id}/serviceAccounts/${each.value}"
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.project_id}.svc.id.goog[${each.key}/${var.ksa_name}]"

  depends_on = [kubernetes_namespace.service_namespace]
}

resource "kubernetes_secret_v1" "secret_workload_identity" {
  for_each = var.project_type == "clan_project" ? local.service_name : {}

  metadata {
    name        = "default"
    namespace   = each.key
    annotations = {
      "kubernetes.io/service-account.name" = "default"
    }
  }
  type = "kubernetes.io/service-account-token"

  depends_on = [kubernetes_default_service_account.service_workload_identity]

}

resource "kubernetes_namespace" "service_namespace" {
  for_each = var.project_type == "clan_project" ? local.service_name : {}

  metadata {
    name = each.key
  }
  lifecycle {
    ignore_changes = [
      metadata[0].labels
    ]
  }
}

resource "kubernetes_service_account_v1" "service_workload_identity" {
  for_each = var.project_type == "clan_project" ? local.service_name : {}

  metadata {
    name        = "workload-identity-sa"
    annotations = {
      "iam.gke.io/gcp-service-account" = "${each.key}@${var.project_id}.iam.gserviceaccount.com"
    }
    namespace = each.key
  }

  depends_on = [kubernetes_namespace.service_namespace]
}

resource "kubernetes_secret_v1" "secret_workload_identity" {
  for_each = var.project_type == "clan_project" ? local.service_name : {}

  metadata {
    name        = "workload-identity-token"
    namespace   = each.key
    annotations = {
      "kubernetes.io/service-account.name" = "workload-identity-sa"
    }
  }
  type = "kubernetes.io/service-account-token"

  depends_on = [kubernetes_service_account_v1.service_workload_identity]
}

resource "kubernetes_role" "ci_cd_namespace_admin_role" {
  for_each = var.project_type == "clan_project" ? local.service_name : {}

  metadata {
    namespace = each.key
    name = "${each.key}-admin"
  }
  rule {
    api_groups  = ["*"]
    resources   = ["*"]
    verbs       = ["*"]
  }

  depends_on = [kubernetes_namespace.service_namespace]
}

resource "kubernetes_cluster_role" "ci_cd_cluster_role" {
  count = var.project_type == "clan_project" ? 1 : 0

  metadata {
    name = "${var.project_id}-cluster-role"
  }
  rule {
    api_groups  = ["*"]
    resources   = ["persistentvolumes", "orders"]
    verbs       = ["*"]
  }

  depends_on = [kubernetes_namespace.service_namespace]
}

resource "kubernetes_cluster_role_binding" "ci_cd_cluster_role_binding" {
  count = var.project_type == "clan_project" ? 1 : 0

  metadata {
    name = var.cicd_service
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "${var.project_id}-cluster-role"
  }
  subject {
    kind      = "User"
    name      = var.cicd_service
    api_group = "rbac.authorization.k8s.io"
  }

  depends_on = [kubernetes_namespace.service_namespace]
}

resource "kubernetes_role_binding" "ci_cd_namespace_admin_role_binding" {
  for_each = var.project_type == "clan_project" ? local.service_name : {}

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
    name      = var.cicd_service
    api_group = "rbac.authorization.k8s.io"
  }

  depends_on = [kubernetes_namespace.service_namespace]
}
