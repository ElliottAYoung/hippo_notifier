module HippoNotifier
  module Services
    module Mailgun
      def self.submit(args)
        @_creds = args[:credentials]
        @notification = args[:notification]

        return nil unless @notification.mediums.include?(:email)

        begin
          Module.const_get(@notification.callback_class.to_s.camelize).send(@notification.callback_method.to_s, @notification.callback_args).deliver_now
        rescue
        end
      end
    end
  end
end
