require 'hippo_notifier/notification'
require 'hippo_notifier/notification_manager'
require 'hippo_notifier/response'
require 'hippo_notifier/service'
require 'hippo_notifier/services/action_mailer'
require 'hippo_notifier/services/pusher'
require 'hippo_notifier/services/twilio'
require 'hippo_notifier/services/pusher/refresher'
require 'hippo_notifier/batches/manager'
require 'hippo_notifier/errors/missing_parameter_error'
require 'hippo_notifier/support/bitly'
require 'hippo_notifier/support/shortener'

module HippoNotifier
  class Client
    attr_reader :credentials
    attr_accessor :batches

    def initialize(args = {})
      @credentials = args[:credentials] || {}
      @batches = []
    end

    def submit(notification_hash, options = {})
      @notification = HippoNotifier::Notification.new(notification_hash)
      results = HippoNotifier::NotificationManager.process(@notification, self, options)
      HippoNotifier::Response.new(results)
    end

    def refresh(args = {})
      results = HippoNotifier::Services::Pusher::Refresher.refresh_data_signal(args, @credentials)
      HippoNotifier::Response.new(results)
    end
  end
end
