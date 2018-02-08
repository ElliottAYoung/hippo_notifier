require 'spec_helper'

RSpec.describe HippoNotifier::Service do
  let(:valid) { HippoNotifier::Service::VALID }

  describe '::VALID' do
    it 'should return an Array' do
      expect(valid).to be_a_kind_of(Array)
    end

    it 'should contain Strings' do
      expect(valid.sample).to be_a_kind_of(String)
    end
  end
end
