require 'test_helper'

class ProductTest < ActiveSupport::TestCase
fixtures :products
test "product attributes must not be empty" do
# свойства товара не должны оставаться пустыми
product = Product.new
assert product.invalid?
assert product.errors[:title].any?
assert product.errors[:description].any?
assert product.errors[:price].any?
assert product.errors[:image_url].any?
end
test "product is not valid without a unique title" do
# если у товара нет уникального названия, то он недопустим
product = Product.new(title: products(:ruby).title,
description: "yyy",
price: 1,
image_url: "fred.gif")
assert product.invalid?
assert_equal ["has already been taken"], product.errors[:title]
# уже было использовано
end
test " product is not valid without a unique title - i18n" do
product = Product.new(title: products(:ruby).title,
description: "yyy",
price: 1,
image_url: "fred.gif")
assert product.invalid?
assert_equal [I18n.translate('activerecord.errors.messages.taken')],
product.errors[:title]
end
# assert true
# end
end


