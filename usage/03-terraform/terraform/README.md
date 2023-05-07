```
terraform init

Initializing the backend...

Initializing provider plugins...
- Finding latest version of hashicorp/vault...
- Installing hashicorp/vault v3.15.2...
- Installed hashicorp/vault v3.15.2 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

```
export VAULT_TOKEN=hvs.uIXvAtKA9NujCFeEBGHviwU3

terraform plan


Terraform used the selected providers to generate the following execution plan. Resource actions are
indicated with the following symbols:
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

────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly
these actions if you run "terraform apply" now.
```
