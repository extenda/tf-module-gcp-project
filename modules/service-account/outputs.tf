output email {
  description = "The service account emails"
  value = {
    for name, sa in google_service_account.sa :
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

#output gsuite_group_email {
#  value = {
#    for key, group in gsuite_group.service_group :
#    group.name => group.email
#  }
#}
