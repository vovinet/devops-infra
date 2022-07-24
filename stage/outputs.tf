output "master_node_ip_address" {
  value = yandex_compute_instance.stage-k8s-cp1[*].network_interface.0.ip_address
}

output "worker_node_ip_address" {
  value = yandex_compute_instance.stage-k8s-node1[*].network_interface.0.ip_address
}