require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module Tasker
  class Application < Rails::Application
  end
end

config.autoload_paths += %W(#{config.root}/app/form_models) if defined? config