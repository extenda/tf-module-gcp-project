# output email {
#   description = "The service account email"
#   value       = length(google_service_account.sa) > 0 ? google_service_account.sa[0].email : null
# }

# output private_key {
#   description = "The service account JSON key"
#   value       = length(google_service_account.sa) > 0 ? base64decode(google_service_account_key.key_json[0].private_key) : null
#   sensitive   = true
# }

# output private_key_encoded {
#   description = "The base64 encoded service account JSON key"
#   value       = length(google_service_account.sa) > 0 ? google_service_account_key.key_json[0].private_key : null
#   sensitive   = true
# }
