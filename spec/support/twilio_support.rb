require 'ostruct'

class SmsTestClient
  def initialize(account_sid, auth_token)
    @account_sid = account_sid
    @auth_token  = auth_token
  end

  def account
    SmsTestClient.new(@account_sid, @auth_token)
  end

  def messages
    SmsTestClient.new(@account_sid, @auth_token)
  end

  def create(args = {})
    args
  end
end

Twilio::REST::Client = SmsTestClient
