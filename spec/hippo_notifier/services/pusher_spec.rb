require 'spec_helper'
require 'support/pusher_support'

RSpec.describe HippoNotifier::Services::Pusher do
  describe '.submit' do
    context 'Given mediums includes :in_app and' do
      let(:notification_args) { { sender_id: 1, receiver_id: 1, mediums: [:in_app], batchable: false } }
      let(:notification) { HippoNotifier::Notification.new(notification_args) }

      context 'Pusher service succeeds' do
        let(:credentials) { { app_id: "123", key: "123", secret: "123", cluster: "123" } }
        let(:options) { { channel: 'test', adapter: {} } }
        let(:result) { HippoNotifier::Services::Pusher.submit( { notification: notification, service_credentials: credentials, options: options }) }

        it 'should return a Hash' do
          expect(result).to be_a_kind_of(Hash)
        end

        it 'should contain the expected data in :service_name' do
          expect(result[:service_name]).to eq('pusher')
        end

        it 'should contain the expected data in :medium' do
          expect(result[:medium]).to eq('in_app')
        end

        it 'should contain the expected data in :message' do
          expect(result[:message]).to eq('ok')
        end
      end

      context 'Pusher service errors out' do
        let(:result) { HippoNotifier::Services::Pusher.submit( { notification: notification }) }

        it 'should return a Hash' do
          expect(result).to be_a_kind_of(Hash)
        end

        it 'should contain the expected data in :service_name' do
          expect(result[:service_name]).to eq('pusher')
        end

        it 'should contain the expected data in :medium' do
          expect(result[:medium]).to eq('in_app')
        end

        it 'should contain the expected data in :message' do
          expect(result[:message]).to eq('An error has occured with Pusher. Please check your configuration and try again')
        end
      end
    end

    context 'Given mediums does not include :in_app and' do
      let(:notification_args) { { sender_id: 1, receiver_id: 1, mediums: [], batchable: false } }
      let(:notification) { HippoNotifier::Notification.new(notification_args) }

      it 'should return nil' do
        result = HippoNotifier::Services::Pusher.submit( { notification: notification })
        expect(result).to be_nil
      end
    end
  end
end
