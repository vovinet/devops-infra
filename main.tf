resource "yandex_vpc_network" "prod_net" {
  name = "Prod-Net"
}

resource "yandex_vpc_subnet" "prod-subnet" {
  name           = "Prod-Subnet-0"
  zone           = local.yc_zone
  network_id     = "${yandex_vpc_network.prod_net.id}"
  v4_cidr_blocks = ["10.0.0.0/24"]
}

resource "yandex_compute_instance" "cp1" {
  name = "k8s-prod-cp1"
  folder_id = local.os_image_id

  resources {
    cores  = 2
    core_fraction = 100
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = local.os_image_id
      size = 5
      type = "network-hdd"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.prod-subnet.id
    nat       = true
  }

  metadata = {
    ssh-keys = "anything:${file("~/.ssh/id_rsa.pub")}"
  }

  scheduling_policy {
    preemptible = true
  }
}

resource "yandex_compute_instance" "prod-node1" {
  name = "k8s-prod-node1"
  folder_id = local.os_image_id

  resources {
    cores  = 2
    core_fraction = 100
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = local.os_image_id
      size = 5
      type = "network-hdd"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.prod-subnet.id
    nat       = true
  }

  metadata = {
    ssh-keys = "anything:${file("~/.ssh/id_rsa.pub")}"
  }

  scheduling_policy {
    preemptible = true
  }
}

resource "yandex_compute_instance" "prod-node2" {
  name = "k8s-prod-node2"
  folder_id = local.os_image_id

  resources {
    cores  = 2
    core_fraction = 100
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = local.os_image_id
      size = 5
      type = "network-hdd"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.prod-subnet.id
    nat       = true
  }

  metadata = {
    ssh-keys = "anything:${file("~/.ssh/id_rsa.pub")}"
  }

  scheduling_policy {
    preemptible = true
  }
}

resource "yandex_compute_instance" "prod-node3" {
  name = "k8s-prod-node3"
  folder_id = local.os_image_id

  resources {
    cores  = 2
    core_fraction = 100
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = local.os_image_id
      size = 5
      type = "network-hdd"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.prod-subnet.id
    nat       = true
  }

  metadata = {
    ssh-keys = "anything:${file("~/.ssh/id_rsa.pub")}"
  }

  scheduling_policy {
    preemptible = true
  }
}