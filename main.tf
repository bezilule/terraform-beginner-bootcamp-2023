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
  #cloud {
  #  organization = "Enat-Terraform-Bootcamp"
  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}
}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}

module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.teacherseat_user_uuid
  bucket_name = var.bucket_name
  index_html_filepath = var.index_html_filepath
 error_html_filepath = var.error_html_filepath
 content_version = var.content_version
  assets_path = var.assets_path
}

resource "terratowns_home" "home" {
  name = "Fall Season!"
  description = <<DESCRIPTION
Fall, or autumn, is a transition from summer to winter marked by shorter days and cooler temperatures. 
The season displays vibrant leaf colors due to pigment changes. It brings a cooler atmosphere, fallen leaves, 
and a shift to warmer clothing. Harvests like pumpkins and apples peak, and cultural celebrations like Thanksgiving occur. 
The fleeting nature of the season also encourages reflection on life's transience, making fall a time to appreciate changing beauty.
DESCRIPTION
  domain_name = module.terrahouse_aws.cloudfront_url
  #domain_name = "3fdq3gz.cloudfront.net"
  town = "the-nomad-pad"
  content_version = 1
}
