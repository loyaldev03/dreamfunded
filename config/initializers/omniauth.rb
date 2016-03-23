Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '53258587093-kl5m6bi61j835409ncebrhr9dtvmt0se.apps.googleusercontent.com', 'zuN6_MdtvUkOlqKfyL9sL6tF'
  provider :linkedin, "7516b9z1t4s1e2", "DI175eyKuk2I67Hj"
end
