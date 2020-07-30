# frozen_string_literal: true

module PromotionalRules
  class ItemsBatchDiscount
    attr_reader :item_code, :threshold, :discount_price

    def initialize(item_code:, threshold:, discount_price:)
      @item_code = item_code
      @threshold = threshold
      @discount_price = discount_price
    end
  end
end
