require 'spec_helper'

RSpec.describe HippoNotifier::Notification do
  let(:args) { { sender_id: 1, receiver_id: 1, mediums: [], batchable: false } }
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

    it 'should set #mediums' do
      expect(notification.mediums).to_not be_nil
    end

    it 'should set #batchable' do
      expect(notification.batchable).to_not be_nil
    end
  end

  describe '#url' do
    it 'should return a String' do
      expect(notification.url).to be_a_kind_of(String)
    end

    it 'should default to an expected value' do
      args[:url] = nil
      notification = HippoNotifier::Notification.new(args)

      expect(notification.url).to eq("")
    end
  end

  describe '#sender_id' do
    it 'should return a Integer' do
      expect(notification.sender_id).to be_a_kind_of(Integer)
    end

    it 'should raise an exception if missing' do
      args[:sender_id] = nil
      expect{ HippoNotifier::Notification.new(args) }.to raise_error(HippoNotifier::Errors::MissingParameterError)
    end
  end

  describe '#receiver_id' do
    it 'should return a Integer' do
      expect(notification.receiver_id).to be_a_kind_of(Integer)
    end

    it 'should raise an exception if missing' do
      args[:receiver_id] = nil
      expect{ HippoNotifier::Notification.new(args) }.to raise_error(HippoNotifier::Errors::MissingParameterError)
    end
  end

  describe '#mediums' do
    it 'should return an Array' do
      expect(notification.mediums).to be_a_kind_of(Array)
    end

    it 'should default to an expected value' do
      args[:mediums] = nil
      notification = HippoNotifier::Notification.new(args)

      expect(notification.mediums).to eq([])
    end
  end

  describe '#batchable' do
    it 'should default to an expected value' do
      args[:batchable] = nil
      notification = HippoNotifier::Notification.new(args)

      expect(notification.batchable).to be false
    end
  end
end
