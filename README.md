# Grafana Dashboards
Grafana dashboards


### Node Exporter Full

For node_exporter

Monitor Linux system.

Only requires the default job_name: node, add as many targets as you need in '/etc/prometheus/prometheus.yml'.


```
  - job_name: node
    static_configs:
      - targets: ['localhost:9100']
```

By default, not all values from vmstat, netstat and interrupts, are exported by prometheus-node-exporter, so some graphs are empty. For get a fully working dashboard, be sure to start the process with this arguments:

```
--collector.netstat.fields=(.*) --collector.vmstat.fields=(.*)  --collector.interrupts

```
In a Debian system, add them to the startup configuration file located in '/etc/default/prometheus-node-exporter'.


Notes:

For prometheus-node-expter v.0.16 or older, use node-exporter-full-old.json

Thanks to the PCP project for document the values reported by the kernel in /proc (in their /pmdas/linux/help src file mainly). Url --> http://pcp.io



### Node Exporter FreeBSD

For node_exporter in FreeBSD system

Monitor FreeBSD system.

Only requires a configured target under any job_name.



### Haproxy Full

For haproxy_exporter

Monitor Haproxy service.

Only requires a configured target under any job_name.



### Haproxy 2.0 Full

For Haproxy compiled with Prometheus support

Monitor Haproxy service direct.

Only requires a configured target under any job_name.



### Apache Full

For apache_exporter

Monitor Apache service.

Only requires a configured target under any job_name.



### NFS Full

For node_exporter

Monitor all NFS and NFSd exported values.

Check that the process was started with the arguments "--collector.nfs" and "--collector.nfsd".

The same as Node Exporter Full. Only requires the default job_name: node, add as many targets as you need in '/etc/prometheus/prometheus.yml'.


