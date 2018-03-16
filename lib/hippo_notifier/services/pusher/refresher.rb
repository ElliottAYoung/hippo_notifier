module HippoNotifier
  module Services
    module Pusher
      module Refresher
        def self.refresh_data_signal(args, creds)
          @creds = creds[:pusher]
          @args = args

          pusher_client.trigger(channel, "notifications", adapter)

          begin
            {
              service_name: 'pusher',
              medium: 'refresh',
              message: 'ok'
            }
          rescue => e
            {
              service_name: 'pusher',
              medium: 'refresh',
              message: e.to_s
            }
          end
        end

        private

        class << self
          def pusher_client
            @client ||= ::Pusher::Client.new(app_id: @creds[:app_id],  key: @creds[:key],  secret: @creds[:secret],  cluster: @creds[:cluster],  encrypted: true)
          end

          def channel
            "private-#{ENV["PUSHER_ENV"]}-#{@args[:object].id}"
          end

          def adapter
            { "data" => { "type" => "refresh_data", "borrower_id" => @args[:id] } }.as_json
          end
        end
      end
    end
  end
end
