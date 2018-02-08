module HippoNotifier
  class Notification
    attr_reader :message_data, :url, :sender_id, :receiver_id, :notification_type, :medium_array, :batchable
    attr_accessor :sent_status_data

    def initialize(args = {}, opts = {})
      @message_data      = args['message_data']
      @url               = args['url']
      @sender_id         = args['sender_id']
      @receiver_id       = args['receiver_id']
      @notification_type = args['notification_type']
      @mediums           = args['mediums']
      @batchable         = args['batchable'] || false

      # Mailgun-specific
      @callback_class    = opts['callback_class']
      @callback_method   = opts['callback_method']
      @callback_args     = opts['callback_args']
    end
  end
end
