require 'delayed_job_active_record'

module HippoNotifier
  module Batches
    module Manager
      def self.manage(args, client, batch_options)
        @batch_options = batch_options || {}

        begin
          process(args, client)

          {
            service_name: 'delayed_jobs',
            medium: 'batch',
            message: 'ok'
          }
        rescue => e
          {
            service_name: 'delayed_jobs',
            medium: 'batch',
            message: e.to_s
          }
        end
      end

      class << self
        def process(args, client)
          binding.pry

          result = ::Batch.find { |b| b.receiver_id == args[:notification].receiver_id && b.sender_id == args[:notification].sender_id }

          if result.nil?
            batch = ::Batch.create(batch_data(args))
            add_to_batch(args[:notification], batch)
            queue_job(batch, client)
          else
            add_to_batch(args[:notification], result)
          end
        end

        private

        def add_to_batch(notification, batch)
          ::Notification.find(notification.id).update({ batch: batch })
        end

        def queue_job(batch, client)
          BatchedNotificationService.new(batch.id).delay(run_at: timeout.from_now).perform
        end

        def timeout
          @batch_options[:timeout] ? @batch_options[:timeout] : 4.minutes
        end

        def batch_data(args)
          {
            sender_id: args[:notification].sender_id,
            sender_type: args[:notification].sender_type,
            receiver_id: args[:notification].receiver_id,
            receiver_type: args[:notification].receiver_type
          }
        end
      end
    end
  end
end
