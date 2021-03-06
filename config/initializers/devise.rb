Devise.setup do |config|
  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'
  require 'devise/orm/active_record'
  config.authentication_keys = [ :username ]
  config.case_insensitive_keys = [ ]
  config.strip_whitespace_keys = [ :username ]
  config.http_authenticatable_on_xhr = false
  config.navigational_formats = ["*/*", :html, :json]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 10
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 4..128
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
end
