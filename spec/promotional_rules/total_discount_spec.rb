# frozen_string_literal: true

RSpec.describe PromotionalRules::TotalDiscount do
  let(:rule) { described_class.new(threshold: 80, discount_percentage: 10) }

  describe '#threshold' do
    subject { rule.threshold }

    it { is_expected.to eq 80 }
  end
end
