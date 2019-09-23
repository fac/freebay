Clearance.configure do |config|
  config.routes = false
  config.mailer_sender = "FreeBay <no-reply@freebay.io>"
  config.rotate_csrf_on_sign_in = true
end
