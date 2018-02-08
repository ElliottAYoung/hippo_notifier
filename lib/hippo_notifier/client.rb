require 'hippo_notifier/notification'
require 'hippo_notifier/notification_manager'
require 'hippo_notifier/services/*'

module HippoNotifier
  class Client
    attr_reader :credentials

    def initialize(args = {})
      @credentials = args[:credentials]
    end

    def submit(notification_hash)
      @notification = HippoNotifier::Notification.new(notification_hash)
      HippoNotifier::NotificationManager.process(@notification, @credentials)
    end
  end
end


# {
#   credentials: {
#     twilio: {
#       api_key: "something",
#       api_secret: "something"
#     },
#     mailgun: {
#       api_key: "something",
#       api_secret: "something"
#     }
#   }
# }
