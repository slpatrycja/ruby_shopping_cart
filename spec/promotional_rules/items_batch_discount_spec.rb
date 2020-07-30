# frozen_string_literal: true

RSpec.describe PromotionalRules::ItemsBatchDiscount do
  let(:rule) { described_class.new(item_code: '001', threshold: 2, discount_price: 8.50) }

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

    it { is_expected.to eq 8.50 }
  end
end
