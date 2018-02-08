require 'spec_helper'

RSpec.describe HippoNotifier::Notification do
  let(:args) { { url: "test.com", sender_id: 1, receiver_id: 1, notification_type: "Test", medium_array: [], batchable: false } }
  let(:notification) { HippoNotifier::Notification.new(args) }

  describe '#initialize' do
    it 'should set #url' do
      expect(notification.url).to_not be_nil
    end

    it 'should set #sender_id' do
      expect(notification.sender_id).to_not be_nil
    end

    it 'should set #receiver_id' do
      expect(notification.receiver_id).to_not be_nil
    end

    it 'should set #notification_type' do
      expect(notification.notification_type).to_not be_nil
    end

    it 'should set #medium_array' do
      expect(notification.medium_array).to_not be_nil
    end

    it 'should set #batchable' do
      expect(notification.batchable).to_not be_nil
    end
  end

  describe '#url' do
  end

  describe '#sender_id' do
  end

  describe '#receiver_id' do
  end

  describe '#notification_type' do
  end

  describe '#medium_array' do
  end

  describe '#batchable' do
  end
end
