Rack::MiniProfiler.config.start_hidden = true

Rails.application.middleware.insert_after ActionDispatch::RequestId, Rack::MiniProfiler