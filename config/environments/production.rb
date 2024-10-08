require "active_support/core_ext/integer/time"

Rails.application.configure do
 
  config.cache_classes = true


  config.eager_load = true


  config.consider_all_requests_local       = false


  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present?

  config.i18n.fallbacks = true


  config.active_support.report_deprecations = false


  config.log_formatter = ::Logger::Formatter.new



  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end


end
