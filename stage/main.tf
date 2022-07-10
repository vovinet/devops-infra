resource "yandex_vpc_network" "stage_net" {
  name = "Stage-Net"
}

resource "yandex_vpc_subnet" "stage-subnet" {
  name           = "Stage-Subnet-0"
  zone           = var.yc_zone
  network_id     = "${yandex_vpc_network.stage_net.id}"
  v4_cidr_blocks = ["10.0.0.0/21"]
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
    nat       = true
  }

  metadata = {
    user-data = file("cloud_config.yaml")
  }

  scheduling_policy {
    preemptible = true
  }
}

resource "yandex_compute_instance" "stage-k8s-node2" {
  name = "stage-k8s-node2"
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
    nat       = true
  }

  metadata = {
    user-data = file("cloud_config.yaml")
  }

  scheduling_policy {
    preemptible = true
  }
}

resource "yandex_compute_instance" "stage-node3" {
  name = "stage-k8s-node3"
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
    nat       = true
  }

  metadata = {
    user-data = file("cloud_config.yaml")
  }

  scheduling_policy {
    preemptible = true
  }
}