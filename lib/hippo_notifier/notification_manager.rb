module HippoNotifier
  module NotificationManager
    def self.process(notification, credentials)
      credentials.keys.each do |service_name|
        if valid_service?(service_name)
          args = {
            notification: notification,
            service_credentials: credentials[service_name]
          }

          HippoNotifier::Services.const_get(service_name.to_s.camelize).send('submit', args)
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
