# Azure-Dev-Ops-01

This Terraform starter creates a small Azure Landing Zone management-group foundation:

- `alz` below the tenant root
- `Platform`, `Landing Zones`, and `Sandbox` child management groups
- The supplied subscription associated with `Landing Zones`
- An allowed-locations policy assignment for the landing-zone scope
- Two audit-only Entra ID-aligned policies at the platform scope: managed identity coverage and Key Vault RBAC authorization

It does not yet create hub networking, Azure Firewall, private DNS, identity resources, or workload subscriptions. Those should be added after deciding whether this subscription is the platform, connectivity, identity, or workload subscription. A production ALZ normally uses separate subscriptions for those concerns.

Azure Policy does not directly configure tenant-level Entra ID controls such as MFA, Conditional Access, or Identity Protection. Those controls require Microsoft Graph/Entra configuration and are intentionally outside this Terraform policy feature.

## Prerequisites

- Terraform >= 1.6
- Azure CLI authenticated to the supplied tenant
- Permissions to create management groups, policy assignments, and subscription associations

```sh
az login --tenant 06091beb-bacb-4e5a-815a-7f644cac1ce5
az account set --subscription 166cdf34-b6b5-4f6c-8380-b5eb960ee824
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform fmt -check
terraform validate
terraform plan
```

Review the plan carefully. Applying this configuration changes tenant-level governance and requires explicit approval:

```sh
terraform apply
```

For shared use, configure an Azure Storage remote backend before applying and do not commit `terraform.tfvars` or state files.

## Azure DevOps pipeline

The `azure-pipelines.yml` pipeline validates every pull request, creates a Terraform plan on `main`, and applies that exact plan through the `alz-production` environment. Configure these Azure DevOps prerequisites before running it:

1. Confirm `Azure-ARM-MainSub01` targets subscription `166cdf34-b6b5-4f6c-8380-b5eb960ee824` in tenant `06091beb-bacb-4e5a-815a-7f644cac1ce5`.
2. Grant the pipeline identity permission to use `Azure-ARM-MainSub01`.
3. Create the `alz-production` environment and configure approvals and checks on it.
4. Import this folder into the Azure DevOps repository and create a pipeline pointing to `azure-pipelines.yml`.