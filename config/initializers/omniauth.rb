Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '53258587093-kl5m6bi61j835409ncebrhr9dtvmt0se.apps.googleusercontent.com', 'zuN6_MdtvUkOlqKfyL9sL6tF',  scope: ['contacts','userinfo.email','userinfo.profile', 'https://www.google.com/m8/feeds/']
  provider :linkedin, "7516b9z1t4s1e2", "DI175eyKuk2I67Hj"
  provider :facebook, "310245845991533", "504d5508b2c9508023bdab69b9c10dd5"
  provider :yahoo_oauth2, "dj0yJmk9ZW1XSENiYzNHMkFVJmQ9WVdrOVdHOVplRmxLTnpnbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD00Ng--", "dd234123852df0e19bf355a73718afa37c05435b", name: 'yahoo'
end

OmniAuth.config.on_failure = Proc.new do |env|
  OmniauthCallbacksController.action(:omniauth_failure).call(env)
  #this will invoke the omniauth_failure action in UsersController.
end
