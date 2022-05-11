{
  _config+:: {
    dashboardTags: ['apache-http-mixin'],
    dashboardPeriod: 'now-1h',
    dashboardTimezone: 'default',
    dashboardRefresh: '1m',

    // for alerts
    alertsWarningWorkersBusy: '80',  // %
  },
}
