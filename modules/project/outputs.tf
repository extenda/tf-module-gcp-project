output project_id {
  description = "The project ID"
  value       = module.project_factory.project_id
}

output project_name {
  description = "The project name"
  value       = module.project_factory.project_name
}

output service_account_email {
  description = "The default service acccount email"
  value       = module.project_factory.service_account_email
}

output ci_cd_service_account_email {
  description = "The CI/CD pipeline service account email"
  value       = module.ci_cd_sa.email
}

output ci_cd_service_account_private_key_encoded {
  description = "The CI/CD pipeline service account base64 encoded JSON key"
  value       = module.ci_cd_sa.private_key_encoded
  sensitive   = true
}

output cloudrun_service_account_email {
  description = "The Cloud Run service account email"
  value       = module.cloudrun_sa.email
}

output secret_manager_service_account_private_key_encoded {
  description = "The Cloud Run service account base64 encoded JSON key"
  value       = module.secret_manager_sa.private_key_encoded
  sensitive   = true
}

output terraform_state_bucket {
  description = "Bucket for saving terraform state of project resources"
  value       = var.bucket_name
}

output service_emails {
  description = "Services service account emails"
  value       = module.services_sa.email
}

output service_private_keys_encoded {
  description = "The Services service account base64 encoded JSON key"
  value       = module.services_sa.private_key_encoded
  sensitive   = true
}

output gsuite_group_email {
  description = "The GSuite group emails created per each service"
  value       = module.services_sa.gsuite_group_email
}

output service_account_emails {
  description = "The service account emails created by service-account submodule"
  value       = module.service_accounts.email
}

output service_account_private_keys_encoded {
  description = "Service accounts base64 encoded JSON keys"
  value       = module.service_accounts.private_key_encoded
  sensitive   = true
}

output gke_service_account_email {
  description = "The GKE service account email created by service-account submodule"
  value       = module.gke_service_accounts.email
}
