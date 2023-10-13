terraform {
    required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }

    }
  #backend "remote" {
  #  hostname = "app.terraform.io"
  #  organization = "Enat-Terraform-Bootcamp"

  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}
  cloud {
    organization = "Enat-Terraform-Bootcamp"
    workspaces {
      name = "terra-house-1"
    }
  }
}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}

module "home_fall_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.fall.public_path
  content_version = var.fall.content_version
}

resource "terratowns_home" "home_fall" {
  name = "Fall Seasone!"
  description = <<DESCRIPTION
Fall, or autumn, is a transition from summer to winter marked by shorter days and cooler temperatures.
The season displays vibrant leaf colors due to pigment changes. It brings a cooler atmosphere, 
fallen leaves, and a shift to warmer clothing. Harvests like pumpkins and apples peak, and cultural 
celebrations like Thanksgiving occur. The fleeting nature of the season also encourages reflection on 
life's transience, making fall a time to appreciate changing beauty.
DESCRIPTION
  domain_name = module.home_fall_hosting.domain_name
  town = "the-nomad-pad"
  content_version = var.fall.content_version
}


module "home_doro-wot_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.doro-wot.public_path
  content_version = var.doro-wot.content_version
}

resource "terratowns_home" "home_doro-wot" {
  name = "Making Ethiopia Dish Doro Wot"
  description = <<DESCRIPTION
Doro Wot, is a traditional Ethiopian dish that can be best described as a rich and spicy chicken stew. It's one of the most beloved dishes in Ethiopian cuisine and often reserved for special occasions, but it's also enjoyed on regular days.
DESCRIPTION
  domain_name = module.home_doro-wot_hosting.domain_name
  town = "the-nomad-pad"
  content_version = var.doro-wot.content_version
}