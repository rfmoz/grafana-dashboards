[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=YPMGFHEDMA6SJ)

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



### Bind9 Full

For prometheus-bind-exporter https://github.com/prometheus-community/bind_exporter

Monitor Bind9 service. Required configuration in /etc/bind/named.conf.options:

```
statistics-channels {
  inet 127.0.0.1 port 8053 allow { 127.0.0.1; };
};
```

On Grafana, it only requires a configured target under any job_name. For example:

```
  - job_name: 'bind'
    static_configs:
        - targets:
           - server_hostname:9119
```


## Donation
If you find this dashboards helpful or/and get from them any comercial profit, maybe you can give me a tip. I will try to continue them with the same quality  :) 

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=YPMGFHEDMA6SJ)
