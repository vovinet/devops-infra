output "stage_k8s_cp1_global_ip" {
  value = yandex_compute_instance.stage-k8s-cp1[*].network_interface.0.nat_ip_address
}
output "stage_k8s_node1_global_ip" {
  value = yandex_compute_instance.stage-k8s-node1[*].network_interface.0.nat_ip_address
}
output "stage_k8s_node2_global_ip" {
  value = yandex_compute_instance.stage-k8s-node2[*].network_interface.0.nat_ip_address
}
output "stage_k8s_node3_global_ip" {
  value = yandex_compute_instance.stage-k8s-node3[*].network_interface.0.nat_ip_address
}