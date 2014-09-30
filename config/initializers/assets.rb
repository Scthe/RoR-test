Rails.application.config.assets.version = '1.0'

# vendor resources
Rails.application.config.assets.precompile += [ 'bootstrap.css', 'bootstrap.js', 'underscore-min.js', 'bootstrap-slider.js' ]
# app resources
Rails.application.config.assets.precompile += %w( tasks.css )
Rails.application.config.assets.precompile += %w( login.css )
Rails.application.config.assets.precompile += [ 'projects.js', 'tasks.js', 'login.js']

# fonts
Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'fonts')  
Rails.application.config.assets.precompile << /\.(?:svg|eot|woff|ttf)$/