{
  prometheusAlerts+:: {
    groups+: [
      {
        name: 'apache-http',
        rules: [
          {
            alert: 'ApacheDown',
            expr: 'apache_up == 0',
            labels: {
              severity: 'warning',
            },
            annotations: {
              summary: 'Apache is down.',
              description: 'Apache is down on {{ $labels.instance }}.',
            },
            'for': '5m',
          },
          {
            alert: 'ApacheRestart',
            expr: 'apache_uptime_seconds_total / 60 < 1',
            labels: {
              severity: 'info',
            },
            annotations: {
              summary: 'Apache restart.',
              description: 'Apache has just been restarted.',
            },
            'for': '0',
          },
          {
            alert: 'ApacheWorkersLoad',
            expr: |||
              (sum by (instance) (apache_workers{state="busy"}) / sum by (instance) (apache_scoreboard) ) * 100 > %(alertsWarningWorkersBusy)s
            ||| % $._config,
            'for': '15m',
            labels: {
              severity: 'warning',
            },
            annotations: {
              summary: 'Apache workers load is too high.',
              description: |||
                Apache workers in busy state approach the max workers count %(alertsWarningWorkersBusy)s%% workers busy on {{ $labels.instance }}.
                The currect value is {{ $value }}%%.
              ||| % $._config,
            },
          },
        ],
      },
    ],
  },
}
