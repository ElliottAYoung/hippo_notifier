require 'twilio-ruby'

module HippoNotifier
  module Services
    module Twilio
      def self.submit(args)
        @creds = args[:service_credentials]
        @notification = args[:notification]
        @options = args[:options]

        return nil unless @notification.mediums.include?('sms')

        begin
          client.account.messages.create(from: @creds[:from_number] , to: @options[:phone_number], body: message)

          {
            service_name: 'twilio',
            medium: 'sms',
            message: 'ok'
          }
        rescue
          {
            service_name: 'twilio',
            medium: 'sms',
            message: 'An error has occured with Twilio. Please check your configuration and try again'
          }
        end
      end

      private

      class << self
        def client
          @client ||= ::Twilio::REST::Client.new(@creds[:account_sid], @creds[:auth_token])
        end

        def message
          message_data = @notification.message_data

          message_data[:sms] ? message_data[:sms] : message_data[:default]
        end
      end
    end
  end
end
