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

Note:
Thanks to the PCP project for document the values reported by the kernel in /proc (in their /pmdas/linux/help src file mainly). Url --> http://pcp.io



### Node Exporter FreeBSD

For node_exporter in FreeBSD system

Only requires a configured target under any job_name.



### Haproxy Full

For haproxy_exporter

Only requires a configured target under any job_name.



### Apache Full

For apache_exporter

Only requires a configured target under any job_name.


