# frozen_string_literal: true

class Item
  attr_reader :code, :name
  attr_accessor :price

  def initialize(code:, name:, price:)
    @code = code
    @name = name
    @price = price
  end
end
