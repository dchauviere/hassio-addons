{
  "ui":true,
  "backend": {
    "file": {
      "path": "/data/vault-db"
    }
  },
  "default_lease_ttl": "168h",
  "max_lease_ttl": "720h",
  "disable_mlock": true,
  "listener":{
    "tcp" :{
      "address": "[::]:8200",
{{ if not .ssl }}
      "tls_disable": 1,
{{ end }}
      "tls_cert_file": "{{ .certfile }}",
      "tls_key_file": "{{ .certfile }}"
    }
  },
  "telemetry": {
    "prometheus_retention_time": "1h"
  }
}