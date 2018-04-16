output "statsd_exporter_ip" {
  value = "${docker_container.statsd_exporter.ip_address}"
}
