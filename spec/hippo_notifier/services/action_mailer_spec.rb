require 'spec_helper'
require 'support/action_mailer_support'

RSpec.describe HippoNotifier::Services::ActionMailer do
  describe '.submit' do
    context 'Given mediums includes :email and' do
      let(:notification_args) { { sender_id: 1, receiver_id: 1, mediums: [:email], batchable: false } }
      let(:notification) { HippoNotifier::Notification.new(notification_args) }

      context 'ActionMailer succeeds' do
        let(:credentials) { {} }
        let(:options) { { klass: 'test_mailer', method: 'test_email', object_hash: {} } }
        let(:result) { HippoNotifier::Services::ActionMailer.submit( { notification: notification, service_credentials: credentials, options: options }) }

        it 'should return a Hash' do
          expect(result).to be_a_kind_of(Hash)
        end

        it 'should contain the expected data in :service_name' do
          expect(result[:service_name]).to eq('action_mailer')
        end

        it 'should contain the expected data in :medium' do
          expect(result[:medium]).to eq('email')
        end

        it 'should contain the expected data in :message' do
          expect(result[:message]).to eq('ok')
        end
      end

      context 'ActionMailer errors out' do
        let(:result) { HippoNotifier::Services::ActionMailer.submit( { notification: notification }) }

        it 'should return a Hash' do
          expect(result).to be_a_kind_of(Hash)
        end

        it 'should contain the expected data in :service_name' do
          expect(result[:service_name]).to eq('action_mailer')
        end

        it 'should contain the expected data in :medium' do
          expect(result[:medium]).to eq('email')
        end

        it 'should contain the expected data in :message' do
          expect(result[:message]).to eq('An error has occured with ActionMailer. Please check your configuration and try again')
        end
      end
    end

    context 'Given mediums does not include :email' do
      let(:notification_args) { { sender_id: 1, receiver_id: 1, mediums: [], batchable: false } }
      let(:notification) { HippoNotifier::Notification.new(notification_args) }

      it 'should return nil' do
        result = HippoNotifier::Services::ActionMailer.submit( { notification: notification })
        expect(result).to be_nil
      end
    end
  end
end
