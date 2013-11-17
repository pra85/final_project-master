class << Rails.application
  def domain
    "localhost:3000"
  end

  def name
    "Ror News"
  end
end

Rails.application.routes.default_url_options[:host] = Rails.application.domain
