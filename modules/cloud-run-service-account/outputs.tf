output private_key {
  value = base64decode(google_service_account_key.key_json.private_key)
}

output private_key_encoded {
  value = google_service_account_key.key_json.private_key
}
