# frozen_string_literal: true

class Checkout
  class UnsupportedItemType < StandardError; end

  attr_reader :promotional_rules, :basket

  def initialize(promotional_rules)
    @promotional_rules = promotional_rules
    @basket = Basket.new
  end

  def scan(item)
    raise UnsupportedItemType unless item.is_a?(Item)

    basket.items << item
    basket.reload_total
  end

  def total
    apply_discounts

    basket.total.round(2)
  end

  private

  def apply_discounts
    promotional_rules.sort_by { |rule| PromotionalRules::ORDER[rule.class.to_s] }.each do |rule|
      rule.apply_to(basket)
    end
  end
end
