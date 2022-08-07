resource "yandex_vpc_network" "stage-net" {
  name = "Stage-Net"
}

resource "yandex_vpc_subnet" "stage-subnet" {
  name           = "Stage-Subnet-0"
  zone           = var.yc_zone
  network_id     = "${yandex_vpc_network.stage-net.id}"
  v4_cidr_blocks = ["10.0.0.0/24"]
}

resource "yandex_vpc_address" "addr_cp" {
  name = "Control Plane Public IP"
  external_ipv4_address {
    zone_id = var.yc_zone
  }
}

#resource "yandex_vpc_address" "addr_node" {
#  name = "Worker Node Public IP"
#  external_ipv4_address {
#    zone_id = var.yc_zone
#  }
#}

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
    ip_address = "10.0.0.12"
    nat       = true
  }

  metadata = {
    user-data = file("cloud_config.yaml")
  }

  scheduling_policy {
    preemptible = true
  }
}

resource "yandex_compute_instance" "stage-k8s-node3" {
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
    ip_address = "10.0.0.13"
    nat       = true
  }

  metadata = {
    user-data = file("cloud_config.yaml")
  }

  scheduling_policy {
    preemptible = true
  }
}

resource "yandex_alb_target_group" "targetgroup01" {
  name      = "targetgroup01"

  target {
    subnet_id = yandex_vpc_subnet.stage-subnet.id
    ip_address = "10.0.0.11"
  }

  target {
    subnet_id = yandex_vpc_subnet.stage-subnet.id
    ip_address = "10.0.0.12"
  }

  target {
    subnet_id = yandex_vpc_subnet.stage-subnet.id
    ip_address = "10.0.0.13"
  }
}

resource "yandex_alb_load_balancer" "stage-balancer" {
  name        = "stage-load-balancer"

  network_id  = yandex_vpc_network.stage-net.id

  allocation_policy {
    location {
      zone_id   = var.yc_zone
      subnet_id = yandex_vpc_subnet.stage-subnet.id 
    }
  }

  listener {
    name = "stage-listener"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [ 80 ]
    }    
    http {
      handler {
        http_router_id = yandex_alb_http_router.stage-router.id
      }
    }
  }    
}

resource "yandex_alb_http_router" "stage-router" {
  name      = "stage-http-router"
  labels = {
    tf-label    = "tf-label-value"
    empty-label = ""
  }
}


resource "yandex_alb_backend_group" "myapp-bg" {
  name      = "my-backend-group"

  http_backend {
    name = "test-http-backend"
    weight = 1
    port = 8080
    target_group_ids = ["${yandex_alb_target_group.target01.id}"]

    load_balancing_config {
      panic_threshold = 50
    }    
    # healthcheck {
    #   timeout = "1s"
    #   interval = "1s"
    #   http_healthcheck {
    #     path  = "/"
    #   }
    # }
    http2 = "true"
  }
}

resource "yandex_alb_backend_group" "graphics-bg" {
  name      = "my-backend-group"

  http_backend {
    name = "test-http-backend"
    weight = 1
    port = 3000
    target_group_ids = ["${yandex_alb_target_group.target01.id}"]

    load_balancing_config {
      panic_threshold = 50
    }    
    # healthcheck {
    #   timeout = "1s"
    #   interval = "1s"
    #   http_healthcheck {
    #     path  = "/"
    #   }
    # }
    http2 = "true"
  }
}

resource "yandex_alb_virtual_host" "vhost-graphics" {
  name      = "vhost-graphics"
  http_router_id = yandex_alb_http_router.stage-router.id
  route {
    name = "graphics"
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.graphics-bg.id
        timeout = "3s"
      }
    }
  }
}

resource "yandex_alb_virtual_host" "vhost-myapp" {
  name      = "vhost-myapp"
  http_router_id = yandex_alb_http_router.stage-router.id
  route {
    name = "myapp"
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.myapp-bg.id
        timeout = "3s"
      }
    }
  }
}