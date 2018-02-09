require 'spec_helper'
require 'support/delayed_job_support'

RSpec.describe HippoNotifier::NotificationManager do
  let(:args) { { sender_id: 1, receiver_id: 1, mediums: [:sms], batchable: false } }
  let(:notification) { HippoNotifier::Notification.new(args) }
  let(:manager) { HippoNotifier::NotificationManager }

  describe '.process' do
    let(:client) { HippoNotifier::Client.new({}) }

    it 'should return an Array' do
      expect(manager.process(notification, client)).to be_a_kind_of(Array)
    end

    context 'Given a valid service name' do
      let(:credentials) { { twilio: 'something' } }
      let(:client) { HippoNotifier::Client.new({ credentials: credentials }) }

      it 'should add the service to the Array' do
        expected = credentials.keys.count
        expect(manager.process(notification, client).length).to eq(expected)
      end

      context 'and the noitification is batchable' do
        let(:args) { { sender_id: 1, receiver_id: 0, mediums: [:sms], batchable: true } }
        let(:notification) { HippoNotifier::Notification.new(args) }

        it 'should return the expected result' do
          response = manager.process(notification, client)
          expect(response.sample[:service_name]).to eq('delayed_jobs')
        end
      end

      context 'and the noitification is not batchable' do
        it 'should return the expected result' do
          response = manager.process(notification, client)
          expect(response.sample[:service_name]).to eq('twilio')
        end
      end
    end

    context 'Given an invalid service name' do
      let(:credentials) { { invalid_service_name: 'something' } }
      let(:client) { HippoNotifier::Client.new({ credentials: credentials }) }

      it 'should not add the service to the Array' do
        expected = credentials.keys.count - 1
        expect(manager.process(notification, client).length).to eq(expected)
      end
    end
  end
end
