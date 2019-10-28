require "sinatra"
require 'action_mailer'

class App < Sinatra::Base
  get "/" do
    erb :index
  end
end

configure do
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.raise_delivery_errors = true
  ActionMailer::Base.smtp_settings = {
    :address => 'smtp.sendgrid.net',
    :port => 587,
    :authentication => :plain,
    :user_name => ENV['SENDGRID_USERNAME'],
    :password => ENV['SENDGRID_PASSWORD'],
    :domain => ENV['MY_DOMAIN'],
    :enable_starttls_auto => true
    }
  ActionMailer::Base.view_paths = File.expand_path('views/')
end

class Mailer < ActionMailer::Base
  default from: "no_reply@beacon_app.com"
  layout 'notify'

	def notify(params)
		@params = params
		mail(to: params[:email], subject: "Emergency Contact Notification: Action Needed")
	end
end

get '/notify' do
  Mailer.notify(params).deliver_now
end
