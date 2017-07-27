# grafana-dashboards
Grafana dashboards

Only requires the default job_name: node, add as many targets as you need.


  - job_name: node
    static_configs:
      - targets: ['localhost:9100']

