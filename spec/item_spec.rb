# frozen_string_literal: true

RSpec.describe Item do
  let(:item) { described_class.new(code: '001', name: 'Red scarf', price: 8.50) }

  describe '#code' do
    subject { item.code }

    it { is_expected.to eq '001' }
  end

  describe '#name' do
    subject { item.name }

    it { is_expected.to eq 'Red scarf' }
  end

  describe '#price' do
    subject { item.price }

    it { is_expected.to eq 8.50 }
  end
end
