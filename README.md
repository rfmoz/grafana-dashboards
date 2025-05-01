# Grafana Dashboards

## Node Exporter Full

- For node_exporter
- Monitor Linux system.

Only requires the default job_name: node, add as many targets as you need in `/etc/prometheus/prometheus.yml`.

```yaml
  - job_name: node
    static_configs:
      - targets: ['localhost:9100']
```

Recommended for prometheus-node-exporter the arguments `--collector.systemd` and `--collector.processes` because the graph uses some of their metrics.

> - `timeInterval` in the Grafana data source has to be set accordingly to the > `scrape_interval` configured in Prometheus. You can do this by navigating to connections > Data sources > Prometheus and set Scrape Interval under Interval behaviour. When using provisioning, this is set with the attribute jsonData.timeInterval.
> - For prometheus-node-exporter v.0.16 or older, use `node-exporter-full-old.> json`
> - Thanks to the [PCP project](http://pcp.io) for document the values reported > by the kernel in `/proc` (in their `/pmdas/linux/help` src file mainly).



## Node Exporter BSD

- For node_exporter in BSD system
- Monitor BSD system.

Only requires a configured target under any `job_name`.



## Haproxy

- For Haproxy v.2 or avobe compiled with Prometheus support
- Monitor Haproxy service.

Only requires a configured target under any `job_name`.



## Apache Full

- Monitor Apache service.

>  Moved to https://github.com/grafana/jsonnet-libs



## NFS Full

- For node_exporter
- Monitor all NFS and NFSd exported values.

Check that the process was started with the arguments `--collector.nfs` and `--collector.nfsd`.

The same as Node Exporter Full. Only requires the default `job_name: node`, add as many targets as you need in `/etc/prometheus/prometheus.yml`.



## BIND 9 Full

- For [prometheus-bind-exporter](https://github.com/prometheus-community/bind_exporter)
- Monitor BIND 9 service. 
 
Required configuration in `/etc/bind/named.conf.options`:

```c++
statistics-channels {
  inet 127.0.0.1 port 8053 allow { 127.0.0.1; };
};
```

On Grafana, it only requires a configured target under any `job_name`. For example:

```yaml
  - job_name: 'bind'
    static_configs:
        - targets:
           - server_hostname:9000
```



## Unbound Full

- For [unbound_exporter](https://github.com/letsencrypt/unbound_exporter)
- Monitor Unbound DNS service. 
 
Required configuration in `/etc/unbound/unbound.conf`:

```server:
        extended-statistics: yes

remote-control:
        control-enable: yes
        control-interface: /run/unbound.ctl
```

On Grafana, it only requires a configured target under any `job_name`. For example:

```yaml
  - job_name: 'unbound'
    static_configs:
        - targets:
           - server_hostname:9167
```
