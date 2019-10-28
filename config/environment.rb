require 'bundler/setup'

ENV['SINATRA_ENV'] ||= "development"
ENV['RACK_ENV'] ||= "development"

Bundler.require(:default, ENV['SINATRA_ENV'])
RACK_ENV=production ruby app.rb

require_all 'app'

config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = { :address => "localhost", :port => 1025 }
