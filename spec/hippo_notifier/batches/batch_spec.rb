require 'spec_helper'

RSpec.describe HippoNotifier::Batches::Batch do
  let(:args) { { id: 1, notification: 'test', options: {} } }
  let(:batch) { HippoNotifier::Batches::Batch.new(args) }

  describe '#initialize' do
    it 'should set #id' do
      expect(HippoNotifier::Batches::Batch.new({ id: 1 }).id).to_not be_nil
    end

    it 'should set #notifications' do
      expect(HippoNotifier::Batches::Batch.new.notifications).to_not be_nil
    end

    context 'Given a valid notification' do
      it 'should seed an initial notification' do
        expect(batch.notifications.count).to eq(1)
      end
    end

    context 'Given no valid notification' do
      it 'should not seed an initial notification' do
        expect(HippoNotifier::Batches::Batch.new.notifications.count).to eq(0)
      end
    end
  end

  describe '#id' do
    it 'should return an Integer' do
      expect(batch.notifications.count).to be_a_kind_of(Integer)
    end
  end

  describe '#notifications' do
    it 'should return an Array' do
      expect(batch.notifications).to be_a_kind_of(Array)
    end

    it 'should persist changes made' do
      count = batch.notifications.count
      batch.notifications << 'something_different'
      expect(batch.notifications.count).to eq(count + 1)
    end
  end
end
