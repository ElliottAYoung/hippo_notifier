require 'spec_helper'

RSpec.describe HippoNotifier::Client do
  let(:client) { HippoNotifier::Client.new }

  describe '#initialize' do
    it 'should set #credentials' do
      expect(HippoNotifier::Client.new.credentials).to_not be_nil
    end
  end

  describe '#submit' do
    it 'should return a HippoNotifier::Response object' do
    end
  end

  describe '#credentials' do
    it 'should return a Hash' do
      expect(client.credentials).to be_a_kind_of(Hash)
    end
  end
end
