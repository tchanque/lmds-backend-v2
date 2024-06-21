require 'sib-api-v3-sdk'

SibApiV3Sdk.configure do |config|
  config.api_key["api-key"] = ENV['BREVO_LMDS']
end