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