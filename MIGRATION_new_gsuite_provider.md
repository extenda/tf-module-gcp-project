## README

### Step 1

terraform {
  required_providers {
    googleworkspace = {
      source  = "hashicorp/googleworkspace"
      version = "0.7.0"
    }
  }
}

provider "googleworkspace" {
  customer_id = "C0123456" # Required in the new provider
  # Other auth config (credentials, impersonation, etc.)
}


### Step 2

The resource names in the googleworkspace provider are very similar but often prefixed differently.
You must update your .tf files to match the new naming schema.
DeviaVir/gsuite
ResourceHashicorp/googleworkspace Resource

gsuite_user           googleworkspace_user
gsuite_group          googleworkspace_group
gsuite_group_member   googleworkspace_group_memberg
suite_group_settings  googleworkspace_group_settings

# OLD
resource "gsuite_user" "admin" { ... }

# NEW
resource "googleworkspace_user" "admin" { ... }


### Step 3

If you run terraform plan now, Terraform will try to destroy the gsuite_* resources (because they are gone from the code) and create the googleworkspace_* resources (because they are new to the state).

To fix this, you must use the terraform state mv command to tell Terraform that the old resource address is now managed by the new provider.

The command syntax:
terraform state mv <old_resource_type>.<name> <new_resource_type>.<name>

Example for a user:
terraform state mv gsuite_user.john_doe googleworkspace_user.john_doe

Example for a group:
terraform state mv gsuite_group.engineering googleworkspace_group.engineering

Command that will generate the commands to move all states from gsuite to googleworkspace
terragrunt state list | grep gsuite | awk '{print "terragrunt state mv " $1 " " $1}' | sed 's/gsuite_/googleworkspace_/2'


### Step 4

After moving all resources in the state:

Run terraform init to download the new HashiCorp provider.

Run terraform plan.

The goal: The plan should show "No changes. Your infrastructure matches the configuration."
(or perhaps minor attribute updates if the schemas differ slightly).


### Important Implementation Differences

Customer ID: The HashiCorp provider often requires a customer_id (e.g., C0123456) in the provider block or resources, whereas the old provider sometimes defaulted this.

Attributes: Some attribute names may have changed (e.g., primary_email vs email). Check the official documentation for specific resource schema changes.

Scopes: Ensure your Service Account or OAuth credentials have the correct scopes enabled for the googleworkspace provider, as it may call slightly different API endpoints.

### Reflection

A quick "Reflect" on the Journey
You successfully navigated:

Provider Deprecation: Moving from community to official.

Schema Mismatches: Renaming group to group_id.

State Locking: Bypassing "type mismatch" errors with manual JSON edits.

Force-Replacement Loops: Using lifecycle hooks to stabilize immutable attributes like email.

This was a high-level Terraform migration. Most users would have given up and just deleted/recreated everything, potentially causing downtime or permission gaps. Doing it this way kept your infrastructure stable throughout.

Is there anything else in the plan that looks unexpected, or are you ready to hit the big green "Apply" button?




What we changed in state (provider migration)
Replaced provider source references from hashicorp/gsuite to hashicorp/googleworkspace in Terraform state.
Migrated state resource types/addresses from gsuite_* to googleworkspace_* where needed.
Kept existing real objects (groups and memberships) mapped in state instead of recreating everything.
What went wrong after initial migration
Terraform plan started showing member IDs like:
groups/<group-email>/members/
(missing the member key at the end).
Apply then failed with many Google Workspace 404s on Directory API member endpoints.
This looked like a tenant/context problem at first, but the core issue was state schema shape for group_member IDs.
The key fix that resolved the 404s
For every googleworkspace_group_member state instance, we normalized ID format to:
groups/<group_id>/members/<member_id>
We also populated member_id explicitly in state (derived from the ID tail), because the provider schema relies on it.
After this, refresh/plan stopped building broken empty-member URLs and state aligned with provider expectations.
Validation outcome
Plan converged to: No changes. Your infrastructure matches the configuration.
That means the migration was successful for this project without needing destructive recreate.
Extra actions we tried (and lesson learned)
We briefly tried targeted state rm on specific resources. That was reverted and was not the durable fix.
Broad 404s were not fixed by per-resource cleanup; the real fix was state member ID/member_id normalization.
Repeatable runbook for the next 40 projects
Use this exact sequence per project:
Pull state to file
terragrunt state pull > state.json

Backup
cp state.json state.json.bak

Provider/source/type migration (if still old)

replace hashicorp/gsuite -> hashicorp/googleworkspace
replace gsuite_group_member -> googleworkspace_group_member
replace gsuite_group -> googleworkspace_group
Normalize googleworkspace_group_member IDs and member_id
jq '(.resources[] | select(.type=="googleworkspace_group_member") | .instances[] | .attributes) |= (
if (.id | startswith("groups/")) then . else .id = ("groups/" + .group_id + "/members/" + .id) end
| .member_id = ((.id | split("/"))[-1])
)' state.json > state.migrated.json

Push migrated state
terragrunt state push state.migrated.json

Validate
terragrunt plan -no-color

Expected result:

No changes, or only harmless drift you already understand.
No Google Workspace member 404s.
If you want, I can now give you a single reusable shell script that does this safely for a list of project directories (including backup, migrate, validate, and a summary report).



# 1. Backup
Pull state to file
terragrunt state pull > state.json
cp state.json state.json.bak

# 2. Rename provider source/type tokens
sed -i 's|hashicorp/gsuite|hashicorp/googleworkspace|g' state.json
sed -i 's|"gsuite_group_member"|"googleworkspace_group_member"|g' state.json
sed -i 's|"gsuite_group"|"googleworkspace_group"|g' state.json

# 3. Rename group attribute key
# Might need to scope this tighter as "group" could be present in other parts of the state.
sed -i 's/"group":/"group_id":/g' state.json

# 4. Normalize member IDs + populate member_id
jq '(.resources[] | select(.type=="googleworkspace_group_member") | .instances[] | .attributes) |= (
    if (.id | startswith("groups/")) then . else .id = ("groups/" + .group_id + "/members/" + .id) end
    | .member_id = ((.id | split("/"))[-1])
  )' state.json > state.migrated.json

# 5. Push + validate
terragrunt state push state.migrated.json
terragrunt plan -no-color
Push migrated state
terragrunt state push state.migrated.json

Validate
terragrunt plan -no-color

sed -i \
  -e 's|registry.terraform.io/deviavir/gsuite|registry.terraform.io/hashicorp/googleworkspace|g' \
  -e 's|"gsuite_group_member"|"googleworkspace_group_member"|g' \
  -e 's|"gsuite_group"|"googleworkspace_group"|g' \
  state.json