class << Rails.application
  def domain
    "projectbroomble.ap01.aws.af.cm"
  end

  def name
    "Ror News"
  end
end

Rails.application.routes.default_url_options[:host] = Rails.application.domain
