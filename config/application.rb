require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Preferences
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    #
    unless Rails.env.test?
      config.action_mailer.delivery_method = :mailgun
      config.action_mailer.mailgun_settings = {
          api_key: ENV['MAILGUN_API_KEY'],
          domain: ENV['MAILGUN_DOMAIN'],
      }
    end

  end
end
