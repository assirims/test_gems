require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TestGems
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    # for local storage
    # brew install vips
    config.load_defaults 7.0

    # to run rails console from remote machine
    config.web_console.permissions = '10.0.0.1/8'

    # gem 'rails-erd' configuration to generate a relation diagram
    if Rails.env.development? #for rails-erd gem to generate a diagram
      def eager_load!
        Zeitwerk::Loader.eager_load_all
      end
    end

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
