# frozen_string_literal: true

RSpec.describe PromotionalRules::ItemsBatchDiscount do
  let(:rule) { described_class.new(item_code: '001', threshold: threshold, discount_price: 7.00) }
  let(:threshold) { 2 }

  let(:item_001) { Item.new(code: '001', name: 'Red scarf', price: 8.50) }
  let(:item_002) { Item.new(code: '002', name: 'Hat', price: 10.50) }
  let(:basket) { Basket.new(items: [item_001, item_002]) }

  describe '#item_code' do
    subject { rule.item_code }

    it { is_expected.to eq '001' }
  end

  describe '#threshold' do
    subject { rule.threshold }

    it { is_expected.to eq 2 }
  end

  describe '#discount_price' do
    subject { rule.discount_price }

    it { is_expected.to eq 7.00 }
  end

  describe '#apply_to' do
    before do
      basket.reload_total
    end

    subject { rule.apply_to(basket) }

    context 'when the number of promotional items is below threshold' do
      it 'does not apply promotion' do
        subject
        expect(basket.total).to eq 19
      end
    end

    context 'when the number of promotional items is over threshold' do
      let(:threshold) { 1 }

      it 'applies promotion' do
        subject
        expect(basket.total).to eq 17.5
      end
    end
  end
end
