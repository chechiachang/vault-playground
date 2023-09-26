module "auth_method_github" {
  source = "../../..//usage/03-terraform-modules/auth_method/github"

  path         = "github-chechia-net"
  organization = "chechia-net"
  description  = "GitHub auth method"
}
