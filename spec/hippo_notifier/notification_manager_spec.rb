require 'spec_helper'

RSpec.describe HippoNotifier::NotificationManager do
  let(:args) { { sender_id: 1, receiver_id: 1, notification_type: "Test", medium_array: [], batchable: false } }
  let(:notification) { HippoNotifier::Notification.new(args) }
  let(:manager) { HippoNotifier::NotificationManager }

  describe '.process' do
    it 'should return an Array' do
      expect(manager.process(notification, {})).to be_a_kind_of(Array)
    end

    context 'Given a valid service name' do
      let(:credentials) { { twilio: 'something' } }

      it 'should add the service to the Array' do
        expected = credentials.keys.count
        expect(manager.process(notification, credentials).length).to eq(expected)
      end
    end

    context 'Given an invalid service name' do
      let(:credentials) { { invalid_service_name: 'something' } }

      it 'should not add the service to the Array' do
        expected = credentials.keys.count - 1
        expect(manager.process(notification, credentials).length).to eq(expected)
      end
    end
  end
end
