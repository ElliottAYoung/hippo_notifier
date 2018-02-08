module HippoNotifier
  class Notification
    attr_reader :message_data, :url, :sender_id, :receiver_id, :notification_type, :medium_array, :batchable

    def initialize(args = {})
      @message_data      = args[:message_data] || {}
      @url               = args[:url] || ""
      @sender_id         = args[:sender_id]
      @receiver_id       = args[:receiver_id]
      @notification_type = args[:notification_type]
      @mediums           = args[:mediums] || []
      @batchable         = args[:batchable] || false

      confirm_valid_parameters
    end

    private

    def confirm_valid_parameters
      missing = []

      ['sender_id', 'receiver_id', 'notification_type'].each do |param|
        missing << param if self.send(param).nil?
      end

      raise HippoNotifier::Errors::MissingParameterError.new(missing) if missing.any?
    end
  end
end
