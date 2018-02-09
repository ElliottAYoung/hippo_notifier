module HippoNotifier
  module Services
    module ActionMailer
      def self.submit(args)
        @notification = args[:notification]
        @options      = args[:options]

        return nil unless @notification.mediums.include?(:email)

        begin
          klass = Object.const_get(@options.klass.to_s.split('_').map(&:capitalize).join)
          klass.send(@options.method.to_s, @options.object_hash).deliver_now
        rescue
        end
      end
    end
  end
end
