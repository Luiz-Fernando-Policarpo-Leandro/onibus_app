# spec/mailers/password_mailer_spec.rb
require "rails_helper"

RSpec.describe PasswordMailer, type: :mailer do
  let!(:user_test) { User.create(valid_user_attributes) }
  let!(:token) { user_test.signed_id(purpose: 'reset_passwords', expires_in: 30.minutes) }
  let(:mail) { PasswordMailer.with(user: user_test, token: token).reset }

  it "renders the headers" do
    expect(mail.subject).to eq("Redefinição de senha")
    expect(mail.to).to eq([ user_test.email ])
    expect(mail.from).to eq([ "admimsupremo@gmail.com" ])
  end

  it "renders the body" do
    expect(mail.body.encoded).to match("requisitou uma nova senha")
  end
end
