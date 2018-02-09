module HippoNotifier
  module NotificationManager
    def self.process(notification, credentials, options = {})
      credentials.keys.each do |service_name|
        if valid_service?(service_name)
          args = {
            notification: notification,
            service_credentials: credentials[service_name],
            options: options
          }

          service_class = service_name.to_s.split('_').map(&:capitalize).join
          HippoNotifier::Services.const_get(service_class).send('submit', args)
        end
      end
    end

    private

    class << self
      def valid_service?(service_name)
        HippoNotifier::Services::VALID.include?(service_name.to_s)
      end
    end
  end
end
