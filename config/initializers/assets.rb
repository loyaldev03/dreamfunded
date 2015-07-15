# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

#CSS

Rails.application.config.assets.precompile += %w( home.css )
Rails.application.config.assets.precompile += %w( menu.css )
Rails.application.config.assets.precompile += %w( signup.css )
Rails.application.config.assets.precompile += %w( login.css )
Rails.application.config.assets.precompile += %w( team.css )
Rails.application.config.assets.precompile += %w( why.css )
Rails.application.config.assets.precompile += %w( news.css )
#---- companies
Rails.application.config.assets.precompile += %w( companies.css )
Rails.application.config.assets.precompile += %w( unauthorized.css )



# Javascripts
Rails.application.config.assets.precompile += %w( links.js )
Rails.application.config.assets.precompile += %w( signup.js )

