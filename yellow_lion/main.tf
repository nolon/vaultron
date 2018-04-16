#############################################################################
# Yellow Lion
# Vault telemetry stack
# statsd_exporter, graphite, Prometheus
#############################################################################

# Variables

variable "prometheus_version" {}
variable "statsd_exporter_version" {}

# statsd_exporter configuration

data "template_file" "statsd_mapping_config" {
  template = "${file("${path.module}/templates/vault-statds-mapping.yml.tpl")}"
}

# statsd_exporter image and container

resource "docker_image" "statsd_exporter" {
  name         = "prom/statsd-exporter:${var.statsd_exporter_version}"
  keep_locally = true
}

resource "docker_container" "statsd_exporter" {
  name  = "vaultron_statsd_exporter"
  image = "${docker_image.statsd_exporter.latest}"
  command = ["-statsd.mapping-config=/statsd-mapping-config.yml"]
  must_run = true
  restart = "always"

  upload = {
    content = "${data.template_file.statsd_mapping_config.rendered}"
    file    = "/statsd-mapping-config.yml"
  }

  ports {
    internal = "9102"
    external = "9102"
    protocol = "tcp"
  }

  ports {
    internal = "9125"
    external = "9125"
    protocol = "tcp"
  }

  ports {
    internal = "9125"
    external = "9125"
    protocol = "udp"
  }

}

# Prometheus configuration

data "template_file" "prometheus_config" {
  template = "${file("${path.module}/templates/vaultron_prometheus_config.yml.tpl")}"
    vars {
    statsd_exporter_ip = "${docker_container.statsd_exporter.ip_address}"
  }
}

# Prometheus image and container

resource "docker_image" "prometheus" {
  name         = "prom/prometheus:${var.prometheus_version}"
  keep_locally = true
}

# Prometheus container resource
resource "docker_container" "prometheus" {
  name  = "vaultron_prometheus"
  image = "${docker_image.prometheus.latest}"

  command = ["--config.file=/prometheus-data/prometheus.yml"]

  upload = {
    content = "${data.template_file.prometheus_config.rendered}"
    file    = "/prometheus-data/prometheus.yml"
  }

  volumes {
    host_path      = "${path.module}/../../../prometheus/data"
    container_path = "/prometheus-data/"
  }

  must_run = true

  ports {
    internal = "9090"
    external = "9090"
    protocol = "tcp"
  }
}
