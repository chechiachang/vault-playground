```
export VAULT_TOKEN=hvs.uIXvAtKA9NujCFeEBGHviwU3

terragrunt plan

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # vault_policy.example_policy will be created
  + resource "vault_policy" "example_policy" {
      + id     = (known after apply)
      + name   = "example_policy"
      + policy = <<-EOT
            path "secret/data/myapp/*" {
              capabilities = ["read"]
            }
            path "secret/data/myapp/config" {
              capabilities = ["read", "list"]
            }
        EOT
    }

Plan: 1 to add, 0 to change, 0 to destroy.

─────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't
guarantee to take exactly these actions if you run "terraform apply" now.
```
