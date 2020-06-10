Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'localhost:8080'
    resource '*', headers: :any, methods: [:get, :post, :delete, :put, :patch, :options, :head]
  end
end