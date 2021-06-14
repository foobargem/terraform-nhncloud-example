data "openstack_networking_network_v2" "vpc" {
  name = "Default Network"
}

data "openstack_networking_subnet_v2" "subnet" {
  network_id = data.openstack_networking_network_v2.vpc.id
  name       = "Default Network"
}

data "openstack_networking_secgroup_v2" "sg" {
  name = "default"
}

data "openstack_images_image_v2" "img_debian10" {
  name        = "Debian 10.7 Buster (2020.12.22)"
  most_recent = true
}
