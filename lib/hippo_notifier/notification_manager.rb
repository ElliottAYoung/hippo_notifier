module HippoNotifier
  module NotificationManager
    def self.process(notification, client, options = {})
      results = []

      if notification.batchable
        results << HippoNotifier::Batches::Manager.manage({ notification: notification }, client, options[:batch])
      end

      client.credentials.keys.each do |service_name|
        next unless valid_service?(service_name)

        args = {
          notification: notification,
          service_credentials: client.credentials[service_name.to_sym],
          options: options[service_name.to_sym]
        }

        service_class = service_name.to_s.split('_').map(&:capitalize).join

        results << HippoNotifier::Services.const_get(service_class).send('submit', args)
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
