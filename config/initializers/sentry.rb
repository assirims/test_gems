Sentry.init do |config|
  config.dsn = 'https://42b22798b54b4c19b726f8875a9f08ac@o4504383024332800.ingest.sentry.io/4504937038610432'
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]

  # Set traces_sample_rate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production.
  config.traces_sample_rate = 1.0
  # or
  config.traces_sampler = lambda do |context|
    true
  end
end
