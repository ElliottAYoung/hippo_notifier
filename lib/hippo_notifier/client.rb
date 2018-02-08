require 'hippo_notifier/notification'
require 'hippo_notifier/notification_manager'
require 'hippo_notifier/services/*'

module HippoNotifier
  class Client
    attr_reader :credentials

    def initialize(args = {})
      @credentials = args[:credentials]
    end

    def submit(notification_hash, options = {})
      @notification = HippoNotifier::Notification.new(notification_hash, options)
      HippoNotifier::NotificationManager.process(@notification, @credentials)
    end
  end
end

#options:
#{
#  callback_class: ,
#  callback_method: ,
#  callback_args: nil
#}
#
#args:
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
