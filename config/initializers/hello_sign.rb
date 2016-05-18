require 'hello_sign'
HelloSign.configure do |config|
  config.api_key = '28f2f575cbddc72b62aef0714c1819a1b05c6c5a103b2704abf40a8e16e2a1ac'
  # You can use email_address and password instead of api_key. But api_key is recommended
  # If api_key, email_address and password are all present, api_key will be used
  # config.email_address = 'email_address'
  # config.password = 'password'
end
