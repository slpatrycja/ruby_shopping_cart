# frozen_string_literal: true

class Basket
  attr_accessor :items

  def initialize(items: [])
    @items = items
  end

  def items_by_code(code)
    items.select { |item| item.code == code }
  end

  def base_total
    @_base_total ||= items.map(&:price).sum(0.00)
  end
end
