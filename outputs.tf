output "ubuntu_ip" {
  value = "connect using: ssh -i ${path.module}/${var.private_ssh_key} ${var.gce_username}@${google_compute_instance.ubuntu_vm.network_interface[0].access_config[0].nat_ip}"
}

output "easytravel_url" {
  value = "http://${google_compute_instance.ubuntu_vm.network_interface[0].access_config[0].nat_ip}:8079"
}