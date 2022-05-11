local grafana = import 'github.com/grafana/grafonnet-lib/grafonnet/grafana.libsonnet';
local dashboard = grafana.dashboard;
local template = grafana.template;

{
  grafanaDashboards+:: {

    'apache-http.json':
      dashboard.new(
        'Apache HTTP server',
        time_from='%s' % $._config.dashboardPeriod,
        editable=false,
        tags=($._config.dashboardTags),
        timezone='%s' % $._config.dashboardTimezone,
        refresh='%s' % $._config.dashboardRefresh,
        graphTooltip='shared_crosshair',
      ).addTemplates(
        [
          {
            current: {
              text: 'default',
              value: 'default',
            },
            hide: 0,
            label: 'Data Source',
            name: 'datasource',
            query: 'prometheus',
            refresh: 1,
            regex: '',
            type: 'datasource',
          },
          template.new(
            name='job',
            label='job',
            datasource='$datasource',
            query='label_values(apache_up, job)',
            current='',
            refresh=2,
            includeAll=true,
            sort=1
          ),
          template.new(
            name='instance',
            label='instance',
            datasource='$datasource',
            query='label_values(apache_up{job=~"$job"}, instance)',
            current='',
            refresh=2,
            includeAll=false,
            sort=1
          ),
        ]
      )
      .addPanels([
        {
          datasource: {
            uid: '${datasource}',
          },
          fieldConfig: {
            defaults: {
              color: {
                mode: 'thresholds',
              },
              decimals: 1,
              mappings: [
                {
                  options: {
                    match: 'null',
                    result: {
                      text: 'N/A',
                    },
                  },
                  type: 'special',
                },
              ],
              thresholds: {
                mode: 'absolute',
                steps: [
                  {
                    color: 'green',
                    value: null,
                  },
                  {
                    color: 'red',
                    value: 80,
                  },
                ],
              },
              unit: 's',
            },
            overrides: [],
          },
          gridPos: {
            h: 3,
            w: 4,
            x: 0,
            y: 0,
          },
          id: 8,
          links: [],
          maxDataPoints: 100,
          options: {
            colorMode: 'none',
            graphMode: 'none',
            justifyMode: 'auto',
            orientation: 'horizontal',
            reduceOptions: {
              calcs: [
                'lastNotNull',
              ],
              fields: '',
              values: false,
            },
            textMode: 'auto',
          },
          pluginVersion: '8.4.5',
          targets: [
            {
              expr: 'apache_uptime_seconds_total{instance=~"$instance"}',
              format: 'time_series',
              intervalFactor: 1,
              refId: 'A',
              step: 240,
            },
          ],
          title: 'Uptime',
          type: 'stat',
        },
        {
          id: 9,
          gridPos: {
            h: 3,
            w: 4,
            x: 4,
            y: 0,
          },
          type: 'stat',
          title: 'Version',
          datasource: {
            uid: '${datasource}',
            type: 'prometheus',
          },
          pluginVersion: '8.4.5',
          maxDataPoints: 100,
          links: [],
          fieldConfig: {
            defaults: {
              mappings: [
                {
                  options: {
                    match: 'null',
                    result: {
                      text: 'N/A',
                    },
                  },
                  type: 'special',
                },
              ],
              thresholds: {
                mode: 'absolute',
                steps: [
                  {
                    color: 'green',
                    value: null,
                  },
                  {
                    color: 'red',
                    value: 80,
                  },
                ],
              },
              color: {
                mode: 'thresholds',
              },
              decimals: 1,
              unit: 'none',
            },
            overrides: [],
          },
          options: {
            reduceOptions: {
              values: false,
              calcs: [
                'lastNotNull',
              ],
              fields: '',
            },
            orientation: 'horizontal',
            textMode: 'auto',
            colorMode: 'none',
            graphMode: 'none',
            justifyMode: 'auto',
          },
          targets: [
            {
              expr: 'apache_version{instance=~"$instance"}',
              legendFormat: '',
              interval: '',
              exemplar: true,
              format: 'time_series',
              intervalFactor: 1,
              refId: 'A',
              step: 240,
              datasource: {
                type: 'prometheus',
                uid: 'grafanacloud-prom',
              },
            },
          ],
        },
        {
          id: 5,
          gridPos: {
            h: 3,
            w: 16,
            x: 8,
            y: 0,
          },
          type: 'state-timeline',
          title: 'Apache Up / Down',
          datasource: {
            uid: '${datasource}',
            type: 'prometheus',
          },
          pluginVersion: '8.4.5',
          links: [],
          options: {
            mergeValues: false,
            showValue: 'never',
            alignValue: 'left',
            rowHeight: 0.9,
            legend: {
              displayMode: 'list',
              placement: 'right',
            },
            tooltip: {
              mode: 'single',
              sort: 'none',
            },
          },
          targets: [
            {
              expr: 'apache_up{instance=~"$instance"}',
              legendFormat: 'Apache up',
              interval: '',
              exemplar: true,
              format: 'time_series',
              intervalFactor: 1,
              refId: 'A',
              step: 240,
              datasource: {
                type: 'prometheus',
                uid: 'grafanacloud-prom',
              },
            },
          ],
          fieldConfig: {
            defaults: {
              custom: {
                lineWidth: 0,
                fillOpacity: 70,
                spanNulls: false,
              },
              color: {
                mode: 'continuous-GrYlRd',
              },
              mappings: [
                {
                  type: 'value',
                  options: {
                    '0': {
                      text: 'Down',
                      color: 'red',
                      index: 1,
                    },
                    '1': {
                      text: 'Up',
                      color: 'green',
                      index: 0,
                    },
                  },
                },
              ],
              thresholds: {
                mode: 'absolute',
                steps: [
                  {
                    color: 'green',
                    value: null,
                  },
                ],
              },
            },
            overrides: [],
          },
          timeFrom: null,
          timeShift: null,
        },
        {
          id: 3,
          gridPos: {
            h: 10,
            w: 12,
            x: 0,
            y: 3,
          },
          type: 'timeseries',
          title: 'Bytes sent',
          datasource: {
            uid: '${datasource}',
          },
          pluginVersion: '8.4.5',
          links: [],
          options: {
            tooltip: {
              mode: 'multi',
              sort: 'none',
            },
            legend: {
              displayMode: 'table',
              placement: 'bottom',
              calcs: [
                'mean',
                'lastNotNull',
                'max',
                'min',
              ],
            },
          },
          targets: [
            {
              expr: 'rate(apache_sent_kilobytes_total{instance=~"$instance"}[$__rate_interval]) * 1000',
              format: 'time_series',
              intervalFactor: 1,
              legendFormat: 'Bytes sent',
              refId: 'A',
              step: 240,
            },
          ],
          fieldConfig: {
            defaults: {
              custom: {
                drawStyle: 'line',
                lineInterpolation: 'linear',
                barAlignment: 0,
                lineWidth: 1,
                fillOpacity: 10,
                gradientMode: 'none',
                spanNulls: true,
                showPoints: 'never',
                pointSize: 5,
                stacking: {
                  mode: 'none',
                  group: 'A',
                },
                axisPlacement: 'auto',
                axisLabel: '',
                scaleDistribution: {
                  type: 'linear',
                },
                hideFrom: {
                  tooltip: false,
                  viz: false,
                  legend: false,
                },
                thresholdsStyle: {
                  mode: 'off',
                },
              },
              color: {
                mode: 'palette-classic',
              },
              mappings: [],
              thresholds: {
                mode: 'absolute',
                steps: [
                  {
                    value: null,
                    color: 'green',
                  },
                  {
                    value: 80,
                    color: 'red',
                  },
                ],
              },
              unit: 'Bps',
            },
            overrides: [],
          },
          timeFrom: null,
          timeShift: null,
        },
        {
          id: 5,
          gridPos: {
            h: 10,
            w: 12,
            x: 12,
            y: 3,
          },
          type: 'timeseries',
          title: 'Apache accesses',
          datasource: {
            uid: '${datasource}',
          },
          pluginVersion: '8.4.5',
          links: [],
          options: {
            tooltip: {
              mode: 'multi',
              sort: 'none',
            },
            legend: {
              displayMode: 'table',
              placement: 'bottom',
              calcs: [
                'mean',
                'lastNotNull',
                'max',
                'min',
              ],
            },
          },
          targets: [
            {
              expr: 'rate(apache_accesses_total{instance=~"$instance"}[$__rate_interval])',
              format: 'time_series',
              intervalFactor: 1,
              legendFormat: 'Accesses',
              refId: 'A',
              step: 240,
            },
          ],
          fieldConfig: {
            defaults: {
              custom: {
                drawStyle: 'line',
                lineInterpolation: 'linear',
                barAlignment: 0,
                lineWidth: 1,
                fillOpacity: 10,
                gradientMode: 'none',
                spanNulls: true,
                showPoints: 'never',
                pointSize: 5,
                stacking: {
                  mode: 'none',
                  group: 'A',
                },
                axisPlacement: 'auto',
                axisLabel: '',
                scaleDistribution: {
                  type: 'linear',
                },
                hideFrom: {
                  tooltip: false,
                  viz: false,
                  legend: false,
                },
                thresholdsStyle: {
                  mode: 'off',
                },
              },
              color: {
                mode: 'palette-classic',
              },
              mappings: [],
              thresholds: {
                mode: 'absolute',
                steps: [
                  {
                    value: null,
                    color: 'green',
                  },
                  {
                    value: 80,
                    color: 'red',
                  },
                ],
              },
              unit: 'reqps',
            },
            overrides: [],
          },
          timeFrom: null,
          timeShift: null,
        },
        {
          id: 2,
          gridPos: {
            h: 10,
            w: 24,
            x: 0,
            y: 13,
          },
          type: 'timeseries',
          title: 'Apache scoreboard statuses',
          datasource: {
            uid: '${datasource}',
          },
          pluginVersion: '8.4.5',
          links: [],
          options: {
            tooltip: {
              mode: 'multi',
              sort: 'desc',
            },
            legend: {
              displayMode: 'table',
              placement: 'right',
              calcs: [
                'mean',
                'lastNotNull',
                'max',
                'min',
              ],
              sortBy: 'Last *',
              sortDesc: true,
            },
          },
          targets: [
            {
              expr: 'apache_scoreboard{instance=~"$instance"}',
              format: 'time_series',
              intervalFactor: 1,
              legendFormat: '{{ state }}',
              refId: 'A',
              step: 240,
            },
          ],
          fieldConfig: {
            defaults: {
              custom: {
                drawStyle: 'line',
                lineInterpolation: 'stepAfter',
                barAlignment: 0,
                lineWidth: 1,
                fillOpacity: 10,
                gradientMode: 'none',
                spanNulls: true,
                showPoints: 'never',
                pointSize: 5,
                stacking: {
                  mode: 'normal',
                  group: 'A',
                },
                axisPlacement: 'auto',
                axisLabel: '',
                scaleDistribution: {
                  type: 'linear',
                },
                hideFrom: {
                  tooltip: false,
                  viz: false,
                  legend: false,
                },
                thresholdsStyle: {
                  mode: 'off',
                },
              },
              color: {
                mode: 'palette-classic',
              },
              mappings: [],
              thresholds: {
                mode: 'absolute',
                steps: [
                  {
                    value: null,
                    color: 'green',
                  },
                  {
                    value: 80,
                    color: 'red',
                  },
                ],
              },
              unit: 'short',
            },
            overrides: [],
          },
          timeFrom: null,
          timeShift: null,
        },
        {
          id: 7,
          gridPos: {
            h: 10,
            w: 12,
            x: 0,
            y: 23,
          },
          type: 'timeseries',
          title: 'Apache worker statuses',
          datasource: {
            uid: '${datasource}',
          },
          pluginVersion: '8.4.5',
          links: [],
          options: {
            tooltip: {
              mode: 'multi',
              sort: 'none',
            },
            legend: {
              displayMode: 'table',
              placement: 'bottom',
              calcs: [
                'mean',
                'lastNotNull',
                'max',
                'min',
              ],
            },
          },
          targets: [
            {
              expr: 'apache_workers{instance=~"$instance"}\n',
              format: 'time_series',
              intervalFactor: 1,
              legendFormat: '{{ state }}',
              refId: 'A',
              step: 240,
            },
          ],
          fieldConfig: {
            defaults: {
              custom: {
                drawStyle: 'line',
                lineInterpolation: 'stepAfter',
                barAlignment: 0,
                lineWidth: 1,
                fillOpacity: 10,
                gradientMode: 'none',
                spanNulls: true,
                showPoints: 'never',
                pointSize: 5,
                stacking: {
                  mode: 'normal',
                  group: 'A',
                },
                axisPlacement: 'auto',
                axisLabel: '',
                scaleDistribution: {
                  type: 'linear',
                },
                hideFrom: {
                  tooltip: false,
                  viz: false,
                  legend: false,
                },
                thresholdsStyle: {
                  mode: 'off',
                },
              },
              color: {
                mode: 'palette-classic',
              },
              mappings: [],
              thresholds: {
                mode: 'absolute',
                steps: [
                  {
                    value: null,
                    color: 'green',
                  },
                  {
                    value: 80,
                    color: 'red',
                  },
                ],
              },
              unit: 'short',
            },
            overrides: [],
          },
          timeFrom: null,
          timeShift: null,
        },
        {
          id: 8,
          gridPos: {
            h: 10,
            w: 12,
            x: 12,
            y: 23,
          },
          type: 'timeseries',
          title: 'Apache CPU load',
          datasource: {
            uid: '${datasource}',
          },
          pluginVersion: '8.4.5',
          links: [],
          options: {
            tooltip: {
              mode: 'multi',
              sort: 'none',
            },
            legend: {
              displayMode: 'table',
              placement: 'bottom',
              calcs: [
                'mean',
                'lastNotNull',
                'max',
                'min',
              ],
            },
          },
          targets: [
            {
              expr: 'apache_cpuload{instance=~"$instance"}',
              format: 'time_series',
              intervalFactor: 1,
              legendFormat: 'Load',
              refId: 'A',
              step: 240,
            },
          ],
          fieldConfig: {
            defaults: {
              custom: {
                drawStyle: 'line',
                lineInterpolation: 'linear',
                barAlignment: 0,
                lineWidth: 1,
                fillOpacity: 10,
                gradientMode: 'none',
                spanNulls: true,
                showPoints: 'never',
                pointSize: 5,
                stacking: {
                  mode: 'none',
                  group: 'A',
                },
                axisPlacement: 'auto',
                axisLabel: '',
                scaleDistribution: {
                  type: 'linear',
                },
                hideFrom: {
                  tooltip: false,
                  viz: false,
                  legend: false,
                },
                thresholdsStyle: {
                  mode: 'off',
                },
              },
              color: {
                mode: 'palette-classic',
              },
              mappings: [],
              thresholds: {
                mode: 'absolute',
                steps: [
                  {
                    value: null,
                    color: 'green',
                  },
                  {
                    value: 80,
                    color: 'red',
                  },
                ],
              },
              unit: 'short',
              min: 0,
            },
            overrides: [],
          },
          timeFrom: null,
          timeShift: null,
        },
      ]),

  },
}
