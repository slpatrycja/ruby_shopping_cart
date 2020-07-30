# ruby_shopping_cart

Solution for https://github.com/chrisface/ruby_shopping_cart

## Implemented classes

### PromotionalRules::TotalDiscount
Represents promotional rule applicable to the whole basket, i.e. when spending over £60, the customer gets 10% off their purchase.

It has two properties: `threshold` (the minimum total value of the purchase) and `discount_percentage` (the percentage of the discount which the customer gets after reaching the threshold).

Example:
```ruby
discount = PromotionalRules::TotalDiscount.new(threshold: 60, discount_percentage: 10)
```

### PromotionalRules::ItemsBatchDiscount
Represents promotional rule applicable to the specific amount of a specific item in basket, i.e. when purchasing 2 or more of the Red Scarf, its price is reduced to £8.50.

It has three properties: `item_code` (the code of the item which the discount applies to), `threshold` (the minimum number of these items in the purchase) and `discount_price` (the new price for the items which is being applied after reaching the threshold).

Example:
```ruby
item = Item.new(code: '001', name: 'Red Scarf', price: 9.25)
discount = PromotionalRules::ItemsBatchDiscount.new(item_code: '001', threshold: 2, discount_price: 8.50)
```

### Item
Represents single buyable item and has three properties: `code`, `name` and `price`. Each of the properties has to be passed to the initializer

Example:
```ruby
item = Item.new(code: '001', name: 'Red Scarf', price: 9.25)
```

### Checkout
Represents the whole shopping process and is initialized with an array of promotional rules. The items (which have to be an instance of the `Item` class) can be added to the checkout using `#scan` method.

Example:
```ruby
item = Item.new(code: '001', name: 'Red Scarf', price: 9.25)
total_discount = PromotionalRules::TotalDiscount.new(threshold: 60, discount_percentage: 10)
batch_discount = PromotionalRules::ItemsBatchDiscount.new(item_code: '001', threshold: 2, discount_price: 8.50)

checkout = Checkout.new([total_discount, batch_discount])
checkout.scan(item)
```

### Basket
Basket is an internal representation of items added to the checkout. It should not be used directly.


## Sample usage

```ruby
item_001 = Item.new(code: '001', name: 'Red Scarf', price: 9.25)
item_002 = Item.new(code: '002', name: 'Hat', price: 10.25)

total_discount = PromotionalRules::TotalDiscount.new(threshold: 60, discount_percentage: 10)
batch_discount = PromotionalRules::ItemsBatchDiscount.new(item_code: '001', threshold: 2, discount_price: 8.50)

checkout = Checkout.new([total_discount, batch_discount])
checkout.scan(item_001)
checkout.scan(item_002)

puts "Total price expected: #{checkout.total}"
```
