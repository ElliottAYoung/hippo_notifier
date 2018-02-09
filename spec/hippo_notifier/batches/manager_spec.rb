require 'spec_helper'
require 'support/delayed_job_support'

RSpec.describe HippoNotifier::Batches::Manager do
  let(:notification_args) { { sender_id: 1, receiver_id: 0, mediums: [:sms], batchable: true } }
  let(:notification) { HippoNotifier::Notification.new(notification_args) }
  let(:creds) { { twilio: {} } }
  let(:args) { { notification: notification, service_credentials: creds, options: {} } }
  let(:client) { HippoNotifier::Client.new(creds) }

  describe '.manage' do
    let(:result) { HippoNotifier::Batches::Manager.manage(args, client) }

    context 'DelayedJob succeeds' do
      it 'should return a Hash' do
        expect(result).to be_a_kind_of(Hash)
      end

      it 'should contain the expected data in :service_name' do
        expect(result[:service_name]).to eq('delayed_jobs')
      end

      it 'should contain the expected data in :medium' do
        expect(result[:medium]).to eq('batch')
      end

      it 'should contain the expected data in :message' do
        expect(result[:message]).to eq('ok')
      end
    end

    context 'An Error occurs' do
      let(:result) { HippoNotifier::Batches::Manager.manage({}, {}) }

      it 'should return a Hash' do
        expect(result).to be_a_kind_of(Hash)
      end

      it 'should contain the expected data in :service_name' do
        expect(result[:service_name]).to eq('delayed_jobs')
      end

      it 'should contain the expected data in :medium' do
        expect(result[:medium]).to eq('batch')
      end

      it 'should contain the expected data in :message' do
        expect(result[:message]).to eq('An error has occurred with DelayedJobs. Please check the configuration and try again.')
      end
    end
  end

  describe '#process' do
    context 'Given a DelayedJob already exists' do
      let(:notification_args) { { sender_id: 1, receiver_id: 1, mediums: [:sms], batchable: true } }
      let(:notification) { HippoNotifier::Notification.new(notification_args) }
      let(:args) { { notification: notification, service_credentials: creds, options: {} } }

      before(:each) do
        batch = HippoNotifier::Batches::Batch.new({ id: notification.receiver_id, notification: notification })
        client.batches << batch
      end

      it 'should add a new notification to client#batches' do
        count = client.batches.find { |batch| batch.id == notification.receiver_id }.notifications.count
        HippoNotifier::Batches::Manager.manage(args, client)

        result = client.batches.find { |batch| batch.id == notification.receiver_id }.notifications.count
        expect(result).to eq(count + 1)
      end
    end

    context 'Given a DelayedJob does not already exist' do
      it 'should add a new batch to the client' do
        count = client.batches.count
        HippoNotifier::Batches::Manager.manage(args, client)

        expect(client.batches.count).to eq(count + 1)
      end
    end
  end

  describe '#track_on_client' do
    let(:batch_data) { { notification: notification, id: 1, options: {} } }
    let(:batch) { HippoNotifier::Batches::Batch.new(batch_data) }

    it 'should add the given notification' do
      count = client.batches.count
      HippoNotifier::Batches::Manager.track_on_client(batch, client)
      expect(client.batches.count).to eq(count + 1)
    end
  end
end
