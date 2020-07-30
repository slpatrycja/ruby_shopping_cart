# frozen_string_literal: true

module PromotionalRules
  class ItemsBatchDiscount
    attr_reader :item_code, :threshold, :discount_price

    def initialize(item_code:, threshold:, discount_price:)
      @item_code = item_code
      @threshold = threshold
      @discount_price = discount_price
    end

    def apply_to(basket)
      items_for_discount = basket.items_by_code(item_code)
      return unless items_for_discount.count <= threshold

      items_for_discount.each { |item| item.price = discount_price }

      basket.reload_total
    end
  end
end
