Clearance.configure do |config|
  config.routes = false
  config.mailer_sender = ENV["MAILER_SENDER"]
  config.rotate_csrf_on_sign_in = true
  config.cookie_expiration = lambda { |cookies| 1.week.from_now.utc }
end
