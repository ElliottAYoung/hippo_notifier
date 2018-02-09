require 'spec_helper'

RSpec.describe HippoNotifier::Client do
  let(:client) { HippoNotifier::Client.new }

  describe '#initialize' do
    it 'should set #credentials' do
      expect(HippoNotifier::Client.new.credentials).to_not be_nil
    end

    it 'should set #batches' do
      expect(HippoNotifier::Client.new.batches).to_not be_nil
    end
  end

  describe '#submit' do
    let(:args) { { sender_id: 1, receiver_id: 1, mediums: [], batchable: false } }

    it 'should return a HippoNotifier::Response object' do
      result = HippoNotifier::Client.new.submit(args)
      expect(result).to be_a_kind_of(HippoNotifier::Response)
    end
  end

  describe '#credentials' do
    it 'should return a Hash' do
      expect(client.credentials).to be_a_kind_of(Hash)
    end
  end

  describe '#batches' do
    it 'should return an Array' do
      expect(client.batches).to be_a_kind_of(Array)
    end

    it 'should persist changes made' do
      count = client.batches.count
      client.batches << 'something'

      expect(client.batches.count).to eq(count + 1)
    end
  end
end
