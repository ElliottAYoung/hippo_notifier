require 'spec_helper'

RSpec.describe HippoNotifier::Response do
  let(:successful) { { message: 'ok', service: 'test_success', medium: 'sms' } }
  let(:unsuccessful) { { message: 'fail', service: 'test_fail', medium: 'sms' } }
  let(:results_array) { [successful, unsuccessful] }
  let(:response) { HippoNotifier::Response.new(results_array) }

  describe '#initialize' do
    it 'should set a value to #data' do
      expect(response.data).to_not be_nil
    end
  end

  describe '#successful' do
    it 'should return an Array' do
      expect(response.successful).to be_a_kind_of(Array)
    end

    it 'should only contain successful notification data' do
      expect(response.successful).to eq([successful])
    end
  end

  describe '#unsuccessful' do
    it 'should return an Array' do
      expect(response.unsuccessful).to be_a_kind_of(Array)
    end

    it 'should only contain unsuccessful notification data' do
      expect(response.unsuccessful).to eq([unsuccessful])
    end
  end

  describe '#data' do
    it 'should return a Hash' do
      expect(response.data).to be_a_kind_of(Hash)
    end

    it 'should have contents matching the expected format' do
      expected = {
        notifications_sent_successfully: [successful],
        notifications_sent_unsuccessfully: [unsuccessful]
      }

      expect(response.data).to eq(expected)
    end

    it 'should remove any nil results' do
      results_array << nil
      result_count = results_array.length
      expect(HippoNotifier::Response.new(results_array).data.length).to eq(result_count - 1)
    end
  end
end
