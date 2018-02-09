module HippoNotifier
  module Services
    module ActionMailer
      def self.submit(args)
        @notification = args[:notification]
        @options      = args[:options]

        return nil unless @notification.mediums.include?(:email)

        begin
          klass = Object.const_get(@options[:klass].to_s.split('_').map(&:capitalize).join)
          klass.send(@options[:method].to_s, @options[:object_hash]).deliver_now

          {
            service_name: 'action_mailer',
            medium: 'email',
            message: 'ok'
          }
        rescue
          {
            service_name: 'action_mailer',
            medium: 'email',
            message: 'An error has occured with ActionMailer. Please check your configuration and try again'
          }
        end
      end
    end
  end
end
