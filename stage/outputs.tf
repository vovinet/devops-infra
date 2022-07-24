output "stage_k8s_cp1_private_ip" {
  value = yandex_compute_instance.stage-k8s-cp1[*].network_interface.0.ip_address
}
output "stage_k8s_cp1_global_ip" {
  value = yandex_compute_instance.stage-k8s-cp1[*].network_interface.0.nat_ip_address
}

output "stage_k8s_node1_private_ip" {
  value = yandex_compute_instance.stage-k8s-node1[*].network_interface.0.ip_address
}
output "stage_k8s_node1_global_ip" {
  value = yandex_compute_instance.stage-k8s-node1[*].network_interface.0.nat_ip_address
}