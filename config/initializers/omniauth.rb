Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '1447029515598856', '43a38fdd571814239e56f450ec400ee0'
end