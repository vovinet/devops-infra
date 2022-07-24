resource "yandex_vpc_network" "prod_net" {
  name = "Prod-Net"
}

resource "yandex_vpc_subnet" "prod_subnet" {
  name           = "Prod-Subnet-0"
  zone           = var.yc_zone
  network_id     = "${yandex_vpc_network.prod_net.id}"
  v4_cidr_blocks = ["10.255.255.0/24"]
}

resource "yandex_vpc_address" "addr_cp" {
  name = "Control Plane Public IP"
  external_ipv4_address {
    zone_id = var.yc_zone
  }
}

resource "yandex_vpc_address" "addr_node1" {
  name = "Worker Node1 Public IP"
  external_ipv4_address {
    zone_id = var.yc_zone
  }
}
resource "yandex_vpc_address" "addr_node2" {
  name = "Worker Node2 Public IP"
  external_ipv4_address {
    zone_id = var.yc_zone
  }
}
resource "yandex_vpc_address" "addr_node3" {
  name = "Worker Node3 Public IP"
  external_ipv4_address {
    zone_id = var.yc_zone
  }
}

resource "yandex_compute_instance" "prod_k8s_cp1" {
  name = "prod-k8s-cp1"
  folder_id = var.folder_id

  resources {
    cores  = 2
    core_fraction = 100
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.os_image_id
      size = 20
      type = "network-hdd"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.prod_subnet.id
    ip_address = "10.255.255.10"
    nat_ip_address = yandex_vpc_address.addr_cp.external_ipv4_address[0].address
    nat       = true
  }

  metadata = {
    user-data = file("cloud_config.yaml")
  }

  scheduling_policy {
    preemptible = true
  }
}

resource "yandex_compute_instance" "prod_k8s_node1" {
  name = "prod-k8s-node1"
  folder_id = var.folder_id

  resources {
    cores  = 2
    core_fraction = 100
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.os_image_id
      size = 20
      type = "network-hdd"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.prod_subnet.id
    ip_address = "10.0.0.21"
    nat_ip_address = yandex_vpc_address.addr_node1.external_ipv4_address[0].address
    nat       = true
  }

  metadata = {
    user-data = file("cloud_config.yaml")
  }

  scheduling_policy {
    preemptible = true
  }
}

resource "yandex_compute_instance" "prod_k8s_node2" {
  name = "prod-k8s-node2"
  folder_id = var.folder_id

  resources {
    cores  = 2
    core_fraction = 100
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.os_image_id
      size = 20
      type = "network-hdd"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.prod_subnet.id
    ip_address = "10.0.0.22"
    nat_ip_address = yandex_vpc_address.addr_node2.external_ipv4_address[0].address
    nat       = true
  }

  metadata = {
    user-data = file("cloud_config.yaml")
  }

  scheduling_policy {
    preemptible = true
  }
}

resource "yandex_compute_instance" "prod_k8s_node3" {
  name = "prod-k8s-node3"
  folder_id = var.folder_id

  resources {
    cores  = 2
    core_fraction = 100
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.os_image_id
      size = 20
      type = "network-hdd"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.prod_subnet.id
    ip_address = "10.0.0.23"
    nat_ip_address = yandex_vpc_address.addr_node3.external_ipv4_address[0].address
    nat       = true
  }

  metadata = {
    user-data = file("cloud_config.yaml")
  }

  scheduling_policy {
    preemptible = true
  }
}