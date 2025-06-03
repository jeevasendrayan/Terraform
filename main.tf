module "vpc" {
    source = "./module/VPC"
}

module "ecs" {
  source    = "./module/ECS"
  vpc_id    = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnets
}
