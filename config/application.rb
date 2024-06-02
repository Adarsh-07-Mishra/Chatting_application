require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Chatapp
  class Application < Rails::Application
    config.load_defaults 7.1

    config.autoload_lib(ignore: %w[assets tasks])
    config.active_job.queue_adapter = :sidekiq
    config.time_zone = "Mumbai"
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
