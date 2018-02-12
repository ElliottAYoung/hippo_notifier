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

          result = client.batches.find { |bat| bat.id == batch_data[:id] }

          if result.nil?
            batch = HippoNotifier::Batches::Batch.new(batch_data)
            track_on_client(batch, client)
            queue_job(batch, client)
          else
            add_to_batch(batch_data, client)
          end
        end

        def track_on_client(batch, client)
          client.batches << batch
        end

        private

        def add_to_batch(batch_data, client)
          batch = client.batches.find { |batch| batch.id == batch_data[:id] }
          batch.notifications << { notification: batch_data[:notification], options: batch_data[:options] }
        end

        def queue_job(batch, client)
          Delayed::Job.enqueue(Jobs::BatchedNotificationJob.new(batch), run_at: timeout.from_now, batch_id: batch.id)
        end

        def updated_notification(notification)
          notification.batchable = false
          notification
        end

        def timeout
          @batch_options[:timeout] ? @batch_options[:timeout] : 2.minutes
        end
      end
    end
  end
end
