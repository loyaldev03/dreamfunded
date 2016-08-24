# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile << /\.(?:svg|eot|woff|ttf)\z/
#CSS
Rails.application.config.assets.precompile += %w( application.css )
Rails.application.config.assets.precompile += %w( loader.css )
Rails.application.config.assets.precompile += %w( home.css.scss )
Rails.application.config.assets.precompile += %w( menu.css.scss )
Rails.application.config.assets.precompile += %w( signup.css.scss )
Rails.application.config.assets.precompile += %w( login.css.scss )
Rails.application.config.assets.precompile += %w( team.css )
Rails.application.config.assets.precompile += %w( why.css.scss )
Rails.application.config.assets.precompile += %w( news.css.scss )
Rails.application.config.assets.precompile += %w( menu.css )
Rails.application.config.assets.precompile += %w( contact_us.css.scss )
#---- companies
Rails.application.config.assets.precompile += %w( companies.css.scss )
Rails.application.config.assets.precompile += %w( unauthorized.css )



# Javascripts
Rails.application.config.assets.precompile += %w( links.js )
Rails.application.config.assets.precompile += %w( signup.js )
Rails.application.config.assets.precompile += %w( docusign.js )
Rails.application.config.assets.precompile += %w( jquery-1.4.2.min.js )
Rails.application.config.assets.precompile += %w( require.js )
Rails.application.config.assets.precompile += %w( request.js )
Rails.application.config.assets.precompile += %w( async.js )
