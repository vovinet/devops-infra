resource "yandex_vpc_network" "stage_net" {
  name = "Stage-Net"
}

resource "yandex_vpc_subnet" "stage-subnet" {
  name           = "Stage-Subnet-0"
  zone           = var.yc_zone
  network_id     = "${yandex_vpc_network.stage_net.id}"
  v4_cidr_blocks = ["10.0.0.0/24"]
}

resource "yandex_vpc_address" "addr_cp" {
  name = "Control Plane Public IP"
  external_ipv4_address {
    zone_id = var.yc_zone
  }
}

resource "yandex_vpc_address" "addr_node" {
  name = "Worker Node Public IP"
  external_ipv4_address {
    zone_id = var.yc_zone
  }
}

resource "yandex_compute_instance" "stage-k8s-cp1" {
  name = "stage-k8s-cp1"
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
    subnet_id = yandex_vpc_subnet.stage-subnet.id
    ip_address = "10.0.0.10"
    nat_ip_address = "51.250.90.61"
    nat       = true
  }

  metadata = {
    user-data = file("cloud_config.yaml")
  }

  scheduling_policy {
    preemptible = true
  }
}

resource "yandex_compute_instance" "stage-k8s-node1" {
  name = "stage-k8s-node1"
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
    subnet_id = yandex_vpc_subnet.stage-subnet.id
    ip_address = "10.0.0.11"
    nat_ip_address = "51.250.12.6"
    nat       = true
  }

  metadata = {
    user-data = file("cloud_config.yaml")
  }

  scheduling_policy {
    preemptible = true
  }
}
