Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '53258587093-kl5m6bi61j835409ncebrhr9dtvmt0se.apps.googleusercontent.com', 'zuN6_MdtvUkOlqKfyL9sL6tF',  scope: ['contacts','userinfo.email','userinfo.profile', 'https://www.google.com/m8/feeds/']
  provider :linkedin, "7516b9z1t4s1e2", "DI175eyKuk2I67Hj"
  provider :facebook, "1711154149164475", "77ca9854afc0e1f4c4b76ed4b2401459"
end

OmniAuth.config.on_failure = Proc.new do |env|
  OmniauthCallbacksController.action(:omniauth_failure).call(env)
  #this will invoke the omniauth_failure action in UsersController.
end
