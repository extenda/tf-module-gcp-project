#!/usr/bin/env bash
count=0

terragrunt_mv() {
  terragrunt state mv "$1" "$2" 2>/dev/null
  if [ $? -eq 0 ]; then
   count=$((count+1))
  fi
}

patch_state() {
  jq '
(
    (.resources[] | select(
        .module=="module.ci_cd_sa" and
        .type=="google_service_account_key" and
        .name=="key_json"
    ).instances[].attributes.service_account_id) = "ci-cd-pipeline"
) | (
    (.resources[] | select(
        .module=="module.cloudrun_sa" and
        .type=="google_service_account_key" and
        .name=="key_json"
    ).instances[].attributes.service_account_id) = "cloudrun-runtime"
)
' tfstate.json > tfstate2.json
}

main() {
  terragrunt_mv 'module.ci_cd_sa.google_service_account.sa[0]' 'module.ci_cd_sa.google_service_account.sa["0"]'
  terragrunt_mv 'module.ci_cd_sa.google_project_iam_member.project["r0"]' 'module.ci_cd_sa.google_project_iam_member.project-roles["0.0"]'
  terragrunt_mv 'module.ci_cd_sa.google_project_iam_member.project["r1"]' 'module.ci_cd_sa.google_project_iam_member.project-roles["0.1"]'
  terragrunt_mv 'module.ci_cd_sa.google_project_iam_member.project["r2"]' 'module.ci_cd_sa.google_project_iam_member.project-roles["0.2"]'
  terragrunt_mv 'module.ci_cd_sa.google_service_account_key.key_json[0]' 'module.ci_cd_sa.google_service_account_key.key_json["0"]'
  terragrunt_mv 'module.cloudrun_sa.google_service_account.sa[0]' 'module.cloudrun_sa.google_service_account.sa["0"]'
  terragrunt_mv 'module.cloudrun_sa.google_project_iam_member.project["r0"]' 'module.cloudrun_sa.google_project_iam_member.project-roles["0.0"]'
  terragrunt_mv 'module.cloudrun_sa.google_project_iam_member.project["r1"]' 'module.cloudrun_sa.google_project_iam_member.project-roles["0.1"]'
  terragrunt_mv 'module.cloudrun_sa.google_service_account_key.key_json[0]' 'module.cloudrun_sa.google_service_account_key.key_json["0"]'
  echo "$count resources has been moved"
  echo "Pulling tfstate file into tfstate.json.."
  terragrunt state pull > ./tfstate.json 2>/dev/null
  echo "Patching local state file.."
  patch_state
  echo "Pushing tfstate file from tfstate2.json.."
  terragrunt state push -force ./tfstate2.json 2>/dev/null
}

# Calling the main to start the execution
main "$@"
