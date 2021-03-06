output email {
  description = "The service account emails"
  value = {
    for name, sa in google_service_account.service_acc :
    name => sa.email
  }
}

output private_key {
  description = "The service account JSON keys"
  value = {
    for name, key in google_service_account_key.key_json :
    name => base64decode(key.private_key)
  }
  sensitive = true
}

output private_key_encoded {
  description = "The base64 encoded service account JSON keys"
  value = {
    for name, key in google_service_account_key.key_json :
    name => key.private_key
  }
  sensitive = true
}
