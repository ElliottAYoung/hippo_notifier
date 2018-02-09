require 'hippo_notifier/notification'
require 'hippo_notifier/notification_manager'
require 'hippo_notifier/response'
require 'hippo_notifier/service'
require 'hippo_notifier/services/action_mailer'
require 'hippo_notifier/services/pusher'
require 'hippo_notifier/services/twilio'
require 'hippo_notifier/errors/missing_parameter_error'

module HippoNotifier
  class Client
    attr_reader :credentials

    def initialize(args = {})
      @credentials = args[:credentials] || {}
    end

    def submit(notification_hash, options = {})
      @notification = HippoNotifier::Notification.new(notification_hash)
      results = HippoNotifier::NotificationManager.process(@notification, @credentials, options)
      HippoNotifier::Response.new(results)
    end
  end
end

#options:
#{
#  klass: 'something',
#  method: 'something',
#  object_hash: {user: user}
#}
#
#args:
# {
#   credentials: {
#     twilio: {
#       api_key: "something",
#       api_secret: "something"
#     },
#     pusher: {
#       api_key: "something",
#       api_secret: "something"
#     }
#   }
# }
