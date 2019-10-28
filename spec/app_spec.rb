require File.expand_path '../spec_helper.rb', __FILE__

RSpec.describe Mailer, type: :mailer do
  let(:email){ Capybara::Node::Simple.new(email.body.to_s)}

  it "Sends a notification email" do
    params = {}
    params[:email] = 'joripeterson@gmail.com'

    email = Mailer.notify(params)

    expect(['no_reply@beacon_app.com']).to eq(email.from)
    expect(['joripeterson@gmail.com']).to eq(email.to)
    expect("Emergency Contact Notification: Action Needed").to eq(email.subject)
  end
end
