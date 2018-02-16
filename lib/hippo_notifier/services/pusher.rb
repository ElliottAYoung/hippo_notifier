require 'pusher'

module HippoNotifier
  module Services
    module Pusher
      def self.submit(args)
        @creds = args[:service_credentials]
        @notification = args[:notification]
        @options = args[:options]

        return nil unless @notification.mediums.include?('in_app')

        begin
          client.trigger(@options[:channel], event, @options[:adapter])

          {
            service_name: 'pusher',
            medium: 'in_app',
            message: 'ok'
          }
        rescue => e
          {
            service_name: 'pusher',
            medium: 'in_app',
            message: e.to_s
          }
        end
      end

      private

      class << self
        def client
          @client ||= ::Pusher::Client.new(app_id: @creds[:app_id],  key: @creds[:key],  secret: @creds[:secret],  cluster: @creds[:cluster],  encrypted: true)
        end

        def event
          @options[:event] || "notifications"
        end
      end
    end
  end
end
