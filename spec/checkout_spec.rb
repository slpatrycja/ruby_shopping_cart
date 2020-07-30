# frozen_string_literal: true

RSpec.describe Checkout do
  let(:item_001) { Item.new(code: '001', name: 'Red Scarf', price: 9.25) }
  let(:item_002) { Item.new(code: '002', name: 'Silver cufflinks', price: 45.00) }
  let(:item_003) { Item.new(code: '003', name: 'Silk Dress', price: 19.95) }

  let(:total_discount) { PromotionalRules::TotalDiscount.new(threshold: 60, discount_percentage: 10) }
  let(:items_batch_discount) { PromotionalRules::ItemsBatchDiscount.new(item_code: item_001.code, threshold: 2, discount_price: 8.50) }
  let(:promotional_rules) { [total_discount, items_batch_discount] }

  let(:checkout) { Checkout.new(promotional_rules) }

  describe '#scan' do
    it 'adds given items to the basket' do
      expect(checkout.basket.items).to eq []

      checkout.scan(item_001)
      checkout.scan(item_002)

      expect(checkout.basket.items).to match_array [item_001, item_002]
    end

    context 'unsupported item type' do
      it 'raises error' do
        expect { checkout.scan('Not an item') }.to raise_error(Checkout::UnsupportedItemType)
      end
    end
  end

  describe '#total' do
    let(:full_items_total) {  [item_001, item_002, item_001, item_003].map(&:price).sum(0.0) } # 83.45

    before do
      checkout.scan(item_001)
      checkout.scan(item_002)
      checkout.scan(item_001)
      checkout.scan(item_003)
    end

    subject { checkout.total }

    context 'with no promotional rules' do
      let(:promotional_rules) { [] }

      it 'returns total of basket items full prices' do
        expect(subject).to eq 83.45
      end
    end

    context 'with total_discount promotional rules' do
      let(:promotional_rules) { [total_discount] }

      it 'returns basket items sum reduced by discount percentage' do
        expect(subject).to eq 75.11
      end
    end

    context 'with items batch promotional rules' do
      let(:promotional_rules) { [items_batch_discount] }

      it 'returns basket items sum reducing price of items from promotional rule' do
        expect(subject).to eq 81.95
      end
    end

    context 'with multiple promotional rules' do
      let(:promotional_rules) { [total_discount, items_batch_discount] }

      it 'returns basket items sum reducing price of items from promotional rule and reduced by discount percentage' do
        expect(subject).to eq 73.76
      end
    end
  end
end
