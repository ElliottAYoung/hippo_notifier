require "spec_helper"

RSpec.describe HippoNotifier do
  describe 'requires' do
    it "should have a version number" do
      expect(HippoNotifier::VERSION).to_not be_nil
    end

    it "should be able to instantiate a client" do
      expect(HippoNotifier::Client.new).to_not be_nil
    end
  end
end
