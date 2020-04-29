#!/usr/bin/env bash

# This depends on default credentials being allowed to read secrets.
# TODO 2 - This token might not have the permissions we need. In that case create one in tf-admin instead.
SECRET_VALUE=$(berglas access sm://pipeline-secrets-1136/github-token)

# Produce safe JSON
jq -n --arg token "$SECRET_VALUE" '{"token":$token}'
