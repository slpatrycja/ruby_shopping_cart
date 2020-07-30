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

    @basket_total.round(2)
  end

  def apply_items_batch_discounts
    promotional_rules.select { |rule| rule.is_a?(PromotionalRules::ItemsBatchDiscount) }.each do |rule|
      if basket.items_by_code(rule.item_code).count <= rule.threshold
        basket.items_by_code(rule.item_code).each { |item| item.price = rule.discount_price }
      end
    end
  end

  def apply_total_discounts
    @basket_total = basket.items.map(&:price).sum(0.00)

    promotional_rules.select { |rule| rule.is_a?(PromotionalRules::TotalDiscount) }.each do |rule|
      @basket_total *= rule.discount_multiplier if @basket_total > rule.threshold
    end
  end
end
