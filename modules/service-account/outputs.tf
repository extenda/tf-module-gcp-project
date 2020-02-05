output email {
  description = "The service account email"
  value       = google_service_account.sa[0].email
}

output private_key {
  description = "The service account JSON key"
  value       = base64decode(google_service_account_key.key_json.private_key)
}

output private_key_encoded {
  description = "The base64 encoded service account JSON key"
  value       = google_service_account_key.key_json.private_key
}
