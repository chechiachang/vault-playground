module "api_server" {
  source = "../app/api_server"
}

module "frontend" {
  source = "../app/frontend"
}

module "microservice" {
  source = "../app/microservice"
}
