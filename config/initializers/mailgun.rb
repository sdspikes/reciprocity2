Mailgun.configure do |config|
  api_key = ENV['MAILGUN_API_KEY']
  domain = ENV['MAILGUN_DOMAIN']

  if api_key && domain
    config.api_key = ENV['MAILGUN_API_KEY']
  else
    message = <<~TEXT
      ************************
      Mailgun API key not set
      If you want to send email, set the API key and domain in .env like so:
      MAILGUN_API_KEY=the-api-key
      MAILGUN_DOMAIN=the-mailgun-domain
      ************************
    TEXT
    puts message
  end
end