require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AppSaika
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.i18n.default_locale = :ja
    # config.active_job.queue_adapter = :sidekiq
    # config.active_job.queue_name_prefix = "app_saika_#{Rails.env}"
    # config.cache_store = :redis_cache_store, {
    #   url: "redis://localhost:6379/0", # Redisのホストとポートを適切に設定
    #   namespace: "app_saika_#{Rails.env}" # 必要に応じて名前空間を設定
    # }
    # config.active_record.default_url_options = { 
    #   adapter: 'postgresql', 
    #   database: 'saika_app_db_28fl', 
    #   username: 'saika_app_db_28fl_user', 
    #   password:ENV['production_DB_PASSWORD'], 
    #   host: 'localhost'
    # }
  
  end
end
