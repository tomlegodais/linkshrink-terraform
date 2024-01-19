module "vpc_network" {
  source             = "./modules/vpc_network"
  project_id         = var.project_id
  region             = var.region
  environment        = var.environment
  resource_prefix    = "linkshrink"
  subnet_cidr        = var.subnet_cidr
  vpc_connector_cidr = var.vpc_connector_cidr
}

module "secret_manager" {
  source      = "./modules/secret_manager"
  environment = var.environment
}

module "cloud_sql" {
  source                           = "./modules/cloud_sql"
  database_name                    = "linkshrink"
  region                           = var.region
  environment                      = var.environment
  postgres_root_password_secret_id = module.secret_manager.postgres_root_password_secret_id
  app_user_password_secret_id      = module.secret_manager.app_user_password_secret_id
  vpc_self_link                    = module.vpc_network.self_link
  depends_on                       = [module.vpc_network, module.secret_manager]
}

module "memorystore" {
  source        = "./modules/memorystore"
  name          = "linkshrink"
  environment   = var.environment
  region        = var.region
  vpc_self_link = module.vpc_network.self_link
  depends_on    = [module.vpc_network]
}

module "cloud_run" {
  source        = "./modules/cloud_run"
  name          = "linkshrink-service"
  region        = var.region
  project_id    = var.project_id
  environment   = var.environment
  dockerimage   = local.dockerimage.service_url
  vpc_connector = module.vpc_network.vpc_connector
  postgres_db = {
    host               = module.cloud_sql.database_host
    name               = module.cloud_sql.database_name
    username           = module.cloud_sql.database_user
    password_secret_id = module.secret_manager.app_user_password_secret_id
  }
  redis_url  = module.memorystore.redis_instance_url
  depends_on = [module.vpc_network, module.cloud_sql, module.memorystore]
}
