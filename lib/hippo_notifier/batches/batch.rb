module HippoNotifier
  module Batches
    class Batch
      attr_reader :id
      attr_accessor :notifications

      def initialize(args = {})
        @id = args[:id].to_i
        @notifications = []

        seed_first(args[:notification], args[:options]) if args[:notification]
      end

      private

      def seed_first(notification, options)
        @notifications << { notification: notification, options: options || {} }
      end
    end
  end
end
