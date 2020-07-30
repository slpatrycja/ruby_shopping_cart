# frozen_string_literal: true

RSpec.describe PromotionalRules::TotalDiscount do
  let(:rule) { described_class.new(threshold: threshold, discount_percentage: 10) }
  let(:threshold) { 80 }

  let(:item_001) { Item.new(code: '001', name: 'Red scarf', price: 8.50) }
  let(:item_002) { Item.new(code: '002', name: 'Hat', price: 10.50) }
  let(:basket) { Basket.new(items: [item_001, item_002]) }

  describe '#threshold' do
    subject { rule.threshold }

    it { is_expected.to eq 80 }
  end

  describe '#apply_to' do
    before do
      basket.reload_total
    end

    subject { rule.apply_to(basket) }

    context 'when basket total is below threshold' do
      it 'does not apply promotion' do
        subject
        expect(basket.total).to eq 19
      end
    end

    context 'when basket total is over threshold' do
      let(:threshold) { 10 }

      it 'applies promotion' do
        subject
        expect(basket.total).to eq 17.1
      end
    end
  end
end
