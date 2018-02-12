module HippoNotifier
  module NotificationManager
    def self.process(notification, client, options = {})
      results = []

      client.credentials.keys.each do |service_name|
        if valid_service?(service_name)
          args = {
            notification: notification,
            service_credentials: client.credentials[service_name.to_sym],
            options: options[service_name.to_sym]
          }

          service_class = service_name.to_s.split('_').map(&:capitalize).join

          if notification.batchable
            results << HippoNotifier::Batches::Manager.manage(args, client, options[:batch])
            break
          else
            results << HippoNotifier::Services.const_get(service_class).send('submit', args)
          end
        end
      end

      results
    end

    private

    class << self
      def valid_service?(service_name)
        HippoNotifier::Service::VALID.include?(service_name.to_s)
      end
    end
  end
end
