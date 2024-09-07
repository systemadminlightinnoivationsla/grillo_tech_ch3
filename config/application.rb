
require_relative "boot"


require "action_controller/railtie"
require "action_view/railtie"


require 'neo4j/driver'

Bundler.require(*Rails.groups)

module MetricsApi
  class Application < Rails::Application
    config.load_defaults 7.0

    #
    config.api_only = true


    config.generators do |g|
      g.orm :null
    end
  end
end