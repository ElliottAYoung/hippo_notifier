module HippoNotifier
  module Services
    module Twilio
      def self.submit(args)
        @creds = args[:service_credentials]
        @notification = args[:notification]

        return nil unless @notification.mediums.include?(:sms)

        begin
          client.account.messages.create(from: @creds[:from_number] , to: to, body: message)
        rescue
        end
      end

      private

      class << self
        def client
          @client ||= Twilio::REST::Client.new(@creds[:account_sid], @creds[:auth_token])
        end

        def message
          message_data = @notification.message_data

          message_data[:sms] ? message_data[:sms] : message_data[:default]
        end
      end
    end
  end
end
