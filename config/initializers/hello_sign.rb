require 'hello_sign'
HelloSign.configure do |config|
  # You might want to put all these keys in environment variables or you can YOLO it.
  config.api_key = Rails.application.secrets.hello_sign_api_key
  config.client_id = Rails.application.secrets.hello_sign_client_id
end