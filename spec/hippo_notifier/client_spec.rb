require 'spec_helper'

RSpec.describe HippoNotifier::Client do
  let(:client) { HippoNotifier::Client.new }

  describe '#initialize' do
    it 'should set #credentials' do
      expect(HippoNotifier::Client.new.credentials).to_not be_nil
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
end
