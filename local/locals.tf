locals {

  domain_name = bharath.bond
  zone_id = Z07539413J8MSA1ZN61QZ
  instance_type = var.environment == "prod" ? "t3.medium" : "t3.micro"

}
