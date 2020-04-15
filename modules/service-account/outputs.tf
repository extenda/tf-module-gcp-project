output email {
  description = "The service account emails"
  value = {
    for sa in google_service_account.sa :
    sa.account_id => sa.email
  }
}

output private_key {
  description = "The service account JSON keys"
  value = {
    for key in google_service_account_key.key_json :
    key.service_account_id => base64decode(key.private_key)
  }
  sensitive = true
}

output private_key_encoded {
  description = "The base64 encoded service account JSON keys"
  value = {
    for key in google_service_account_key.key_json :
    key.service_account_id => key.private_key
  }
  sensitive = true
}

output gsuite_group_email {
  value = {
    for group in gsuite_group.service_group :
    group.name => group.email
  }
}
