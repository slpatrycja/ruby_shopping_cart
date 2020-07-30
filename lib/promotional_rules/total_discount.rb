# frozen_string_literal: true

module PromotionalRules
  class TotalDiscount
    attr_reader :threshold

    def initialize(threshold:, discount_percentage:)
      @threshold = threshold
      @discount_percentage = discount_percentage
    end

    def apply_to(basket)
      basket.total *= discount_multiplier if basket.total > threshold
    end

    private

    attr_reader :discount_percentage

    def discount_multiplier
      1 - (discount_percentage / 100.00)
    end
  end
end
