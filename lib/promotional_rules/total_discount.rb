# frozen_string_literal: true

module PromotionalRules
  class TotalDiscount
    attr_reader :threshold

    def initialize(threshold:, discount_percentage:)
      @threshold = threshold
      @discount_percentage = discount_percentage
    end

    def discount_multiplier
      1 - (discount_percentage / 100.00)
    end

    private

    attr_reader :discount_percentage
  end
end
