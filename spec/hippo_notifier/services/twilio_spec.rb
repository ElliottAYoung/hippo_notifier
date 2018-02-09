require 'spec_helper'
require 'support/twilio_support'

RSpec.describe HippoNotifier::Services::Twilio do
  describe '.submit' do
    context 'Given mediums includes :sms and' do
      let(:notification_args) { { sender_id: 1, receiver_id: 1, mediums: [:sms], batchable: false } }
      let(:notification) { HippoNotifier::Notification.new(notification_args) }

      context 'Twilio service succeeds' do
        let(:credentials) { { account_sid: "12345", auth_token: "12345", from_number: "12345678910" } }
        let(:options) { { phone_number: '12345678910' } }
        let(:result) { HippoNotifier::Services::Twilio.submit( { notification: notification, service_credentials: credentials, options: options }) }

        it 'should return a Hash' do
          expect(result).to be_a_kind_of(Hash)
        end

        it 'should contain the expected data in :service_name' do
          expect(result[:service_name]).to eq('twilio')
        end

        it 'should contain the expected data in :medium' do
          expect(result[:medium]).to eq('sms')
        end

        it 'should contain the expected data in :message' do
          expect(result[:message]).to eq('ok')
        end
      end

      context 'Twilio service errors out' do
        let(:result) { HippoNotifier::Services::Twilio.submit( { notification: notification }) }

        it 'should return a Hash' do
          expect(result).to be_a_kind_of(Hash)
        end

        it 'should contain the expected data in :service_name' do
          expect(result[:service_name]).to eq('twilio')
        end

        it 'should contain the expected data in :medium' do
          expect(result[:medium]).to eq('sms')
        end

        it 'should contain the expected data in :message' do
          expect(result[:message]).to eq('An error has occured with Twilio. Please check your configuration and try again')
        end
      end
    end

    context 'Given mediums does not include :sms' do
      let(:notification_args) { { sender_id: 1, receiver_id: 1, mediums: [], batchable: false } }
      let(:notification) { HippoNotifier::Notification.new(notification_args) }

      it 'should return nil' do
        result = HippoNotifier::Services::Twilio.submit( { notification: notification })
        expect(result).to be_nil
      end
    end
  end
end
