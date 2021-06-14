resource "openstack_networking_port_v2" "nic" {
  count = length(var.machines)

  network_id = data.openstack_networking_network_v2.vpc.id
  fixed_ip {
    subnet_id = data.openstack_networking_subnet_v2.subnet.id
  }
  security_group_ids = [
    data.openstack_networking_secgroup_v2.sg.id
  ]
}

resource "openstack_compute_instance_v2" "vm" {
  count = length(var.machines)

  name              = var.machines[count.index].name
  availability_zone = var.machines[count.index].availability_zone
  flavor_name       = var.machines[count.index].flavor_name
  key_pair          = var.machines[count.index].key_pair

  block_device {
    uuid                  = data.openstack_images_image_v2.img_debian10.id
    source_type           = "image"
    destination_type      = "volume"
    delete_on_termination = true
    volume_size           = 20
    volume_type           = "General HDD"
  }

  network {
    port = openstack_networking_port_v2.nic[count.index].id
  }
}
