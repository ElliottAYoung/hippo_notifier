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
        rescue
          {
            service_name: 'delayed_jobs',
            medium: 'batch',
            message: 'An error has occurred with DelayedJobs. Please check the configuration and try again.'
          }
        end
      end

      class << self
        def process(args, client)
          batch_data = {
            notification: updated_notification(args[:notification]),
            id: args[:notification].receiver_id,
            options: args[:options]
          }

          result = Batch.find { |b| b.receiver_id == args[:notification].receiver_id && b.sender_id == args[:notification].sender_id }

          if result.nil?
            batch = Batch.create(batch_data(args))
            queue_job(batch, client)
          else
            add_to_batch(args[:notification], result)
          end
        end

        private

        def add_to_batch(notification, batch)
          Notification.find(notification.id).update({ batch: result })
        end

        def queue_job(batch, client)
          BatchedNotificationService.new(batch.id).delay(run_at: timeout.from_now).perform
        end

        def timeout
          @batch_options[:timeout] ? @batch_options[:timeout] : 4.minutes
        end

        def batch_data
          {
            notification_id: args[:notification].id,
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
