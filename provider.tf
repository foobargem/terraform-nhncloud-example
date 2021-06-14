# Define required providers
terraform {
required_version = ">= 1.0.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.42.0"
    }
  }
  backend "swift" {}
}

provider "openstack" {
  region    = var.provider_openstack.region
  auth_url  = var.provider_openstack.auth_url
  tenant_id = var.provider_openstack.tenant_id
  user_name = var.provider_openstack.user_name
  password  = var.provider_openstack.password
}
