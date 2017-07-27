# Grafana Dashboards
Grafana dashboards


### Node Exporter Full

For node_exporter

Only requires the default job_name: node, add as many targets as you need in '/etc/prometheus/prometheus.yml'.


```
  - job_name: node
    static_configs:
      - targets: ['localhost:9100']
```


### Haproxy Full

For haproxy_exporter

Only requires a configured target under any job_name.
