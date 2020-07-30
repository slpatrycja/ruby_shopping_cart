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
  end

  def total
    apply_items_batch_discounts
    apply_total_discounts

    @final_basket_value.round(2)
  end

  private

  def apply_items_batch_discounts
    promotional_rules.select { |rule| rule.is_a?(PromotionalRules::ItemsBatchDiscount) }.each do |rule|
      items_for_discount = basket.items_by_code(rule.item_code)

      if items_for_discount.count <= rule.threshold
        items_for_discount.each { |item| item.price = rule.discount_price }
      end
    end
  end

  def apply_total_discounts
    @final_basket_value = basket.base_total

    promotional_rules.select { |rule| rule.is_a?(PromotionalRules::TotalDiscount) }.each do |rule|
      @final_basket_value *= rule.discount_multiplier if @final_basket_value > rule.threshold
    end
  end
end
