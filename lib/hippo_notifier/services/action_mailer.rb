module HippoNotifier
  module Services
    module ActionMailer
      def self.submit(args)
        @notification = args[:notification]
        @options      = args[:options] || {}

        return nil unless @notification.mediums.include?('email')

        begin
          mailer_klass.send('process_email', object_hash).deliver_now!

          {
            service_name: 'action_mailer',
            medium: 'email',
            message: 'ok'
          }
        rescue => e
          {
            service_name: 'action_mailer',
            medium: 'email',
            message: e.to_s
          }
        end
      end

      def self.object_hash
        object_hash = {
          subject: @notification.message_data[:default],
          message: @notification.message_data[:email] || @notification.message_data[:default],
          notification_type: @options[:method].to_s,
          url: @notification.url,
          receiver_type: @notification.receiver_type.downcase,
          receiver_id: @notification.receiver_id
        }

        object_hash[@notification.receiver_type.downcase.to_sym] = @notification.receiver_id
        object_hash[@notification.sender_type.downcase.to_sym] = @notification.sender_id

        object_hash
      end
    end
  end
end
