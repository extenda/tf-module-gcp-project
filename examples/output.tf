output sa_emails {
  value = module.service-account.email
}

output private_keys {
  value     = module.service-account.private_key
  sensitive = true
}

output private_keys_encoded {
  value     = module.service-account.private_key_encoded
  sensitive = true
}
