module "sre" {
  source = "../team/sre"
}

module "backend" {
  source = "../team/backend"
}

module "dba" {
  source = "../team/dba"
}
