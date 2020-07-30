# frozen_string_literal: true

RSpec.describe Basket do
  let(:item_001) { Item.new(code: '001', name: 'Red scarf', price: 8.50) }
  let(:item_002) { Item.new(code: '002', name: 'Hat', price: 10.50) }

  let(:basket) { described_class.new(items: [item_001, item_002]) }

  describe '#items' do
    subject { basket.items }

    it { is_expected.to match_array [item_001, item_002] }
  end

  describe '#items_by_code' do
    subject { basket.items_by_code('001') }

    it { is_expected.to eq [item_001] }
  end

  describe '#reload_total' do
    subject { basket.reload_total }

    it 'assigns proper value to @total' do
      subject
      expect(basket.total).to eq 19
    end
  end
end
