require 'active_support/core_ext/hash/indifferent_access'

module HippoNotifier
  class Notification
    attr_reader :message_data, :url, :sender_id, :receiver_id, :mediums, :sender_type, :receiver_type
    attr_accessor :batchable

    def initialize(args = {})
      args = ActiveSupport::HashWithIndifferentAccess.new(args)

      @message_data      = args[:message_data] || {}
      @url               = args[:url] || ""
      @sender_id         = args[:sender_id]
      @receiver_id       = args[:receiver_id]
      @sender_type       = args[:sender_type]
      @receiver_type     = args[:receiver_type]
      @mediums           = args[:mediums] || []
      @batchable         = args[:batchable] || false

      confirm_valid_parameters
    end

    private

    def confirm_valid_parameters
      missing = []

      ['sender_id', 'receiver_id', 'sender_type', 'receiver_type'].each do |param|
        missing << param if self.send(param).nil?
      end

      raise HippoNotifier::Errors::MissingParameterError.new(missing) if missing.any?
    end
  end
end
