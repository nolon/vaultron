# Vaultron Prometheus configuration

global:
  scrape_interval:     15s
  evaluation_interval: 30s

  external_labels:
    monitor: vaultron
    lab:     true

scrape_configs:
  - job_name: 'prometheus'

    scrape_interval: 5s

    static_configs:
      - targets: ['localhost:9090']

  - job_name: vault

    static_configs:

    - targets: ['${statsd_exporter_ip}:9102']
      labels:
        exporter: true
        test:     true

# - job_name: consul-disco-example
#
#   consul_sd_configs:
#   - server: 'localhost:1234'
#     token: mysecret
#     services: ['vault']
#     tag: "vaultron"
#     node_meta:
#       example: "true"
#     allow_stale: true
#     scheme: https
#     tls_config:
#       ca_file: valid_ca_file
#       cert_file: valid_cert_file
#       key_file:  valid_key_file
#       insecure_skip_verify: false
#
#   relabel_configs:
#   - source_labels: [__meta_sd_consul_tags]
#     separator:     ','
#     regex:         label:([^=]+)=([^,]+)
#     target_label:  ${1}
#     replacement:   ${2}

alerting:
  alertmanagers:
