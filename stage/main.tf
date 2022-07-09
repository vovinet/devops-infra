resource "yandex_vpc_network" "stage_net" {
  name = "Stage-Net"
}

resource "yandex_vpc_subnet" "Stage-subnet" {
  name           = "Stage-Subnet-0"
  zone           = var.yc_zone
  network_id     = "${yandex_vpc_network.stage_net.id}"
  v4_cidr_blocks = ["10.0.0.0/24"]
}

resource "yandex_compute_instance" "cp1" {
  name = "k8s-Stage-cp1"
  folder_id = var.os_image_id

  resources {
    cores  = 2
    core_fraction = 100
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.os_image_id
      size = 5
      type = "network-hdd"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.Stage-subnet.id
    nat       = true
  }

  metadata = {
    ssh-keys = "anything:$var.ssh_pub_key"
  }

  scheduling_policy {
    preemptible = true
  }
}

resource "yandex_compute_instance" "Stage-node1" {
  name = "k8s-Stage-node1"
  folder_id = var.os_image_id

  resources {
    cores  = 2
    core_fraction = 100
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.os_image_id
      size = 5
      type = "network-hdd"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.Stage-subnet.id
    nat       = true
  }

  metadata = {
    ssh-keys = "anything:$var.ssh_pub_key"
  }

  scheduling_policy {
    preemptible = true
  }
}

resource "yandex_compute_instance" "Stage-node2" {
  name = "k8s-Stage-node2"
  folder_id = var.os_image_id

  resources {
    cores  = 2
    core_fraction = 100
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.os_image_id
      size = 5
      type = "network-hdd"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.Stage-subnet.id
    nat       = true
  }

  metadata = {
    ssh-keys = "anything:$var.ssh_pub_key"
  }

  scheduling_policy {
    preemptible = true
  }
}

resource "yandex_compute_instance" "Stage-node3" {
  name = "k8s-Stage-node3"
  folder_id = var.os_image_id

  resources {
    cores  = 2
    core_fraction = 100
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.os_image_id
      size = 5
      type = "network-hdd"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.Stage-subnet.id
    nat       = true
  }

  metadata = {
    ssh-keys = "anything:$var.ssh_pub_key"
  }

  scheduling_policy {
    preemptible = true
  }
}