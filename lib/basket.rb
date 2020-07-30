# frozen_string_literal: true

class Basket
  attr_accessor :items, :total

  def initialize(items: [])
    @items = items
    @total = nil
  end

  def items_by_code(code)
    items.select { |item| item.code == code }
  end

  def reload_total
    @total = items.map(&:price).sum(0.00)
  end
end
