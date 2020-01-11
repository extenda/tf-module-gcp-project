output private_key {
  value = base64decode(google_service_account_key.key_json.private_key)
}

output privte_key_encoded {
  value = google_service_account_key.key_json.private_key
}
