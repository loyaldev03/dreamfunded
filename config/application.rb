require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'rails_autolink'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Dreamfunded
  class Application < Rails::Application
    SuckerPunch.logger = Logger.new("#{Rails.root}/log/sucker_punch.log")
    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += Dir["#{config.root}/lib/**/"]
    config.generators do |g|
      g.scaffold_controller "scaffold_controller"
    end

    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.middleware.use "PDFKit::Middleware", :print_media_type => true
    #config.middleware.use Oink::Middleware, :logger => Hodel3000CompliantLogger.new(STDOUT)
  end
end

