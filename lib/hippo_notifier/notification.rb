module HippoNotifier
  class Notification
    attr_reader :message_data, :url, :sender_id, :receiver_id, :notification_type, :medium_array, :batchable
    attr_accessor :sent_status_data

    def initialize(args = {})
      @message_data      = args['message_data']
      @url               = args['url']
      @sender_id         = args['sender_id']
      @receiver_id       = args['receiver_id']
      @notification_type = args['notification_type']
      @medium_array      = args['medium_array']
      @batchable         = args['batchable'] || false
    end
  end
end
