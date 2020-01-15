output project_id {
  value = module.project_factory.project_id
}

output project_name {
  value = module.project_factory.project_name
}

output service_account_email {
  value = module.project_factory.service_account_email
}

output ci_cd_service_account_email {
  value = module.ci_cd_sa.email
}

output cloudrun_service_account_email {
  value = module.cloudrun_sa.email
}
