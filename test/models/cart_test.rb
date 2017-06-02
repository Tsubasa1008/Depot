require 'test_helper'

class CartTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  # 加入測試資料
  fixtures :products

  test "空的購物車中加入一項商品，驗證購物車中品項數目、該商品總數及總金額" do
     cart = Cart.create
     cart.add_product(products(:one)).save!
     assert_equal 1, cart.line_items[0].quantity
     assert_equal 1, cart.line_items.size
     assert_equal products(:one).price, cart.total_price
  end

  test "空的購物車中加入兩項不同商品，驗證購物車中品項數目、該商品總數及總金額" do
     cart = Cart.create
     cart.add_product(products(:one)).save!
     cart.add_product(products(:ruby)).save!
     assert_equal 1, cart.line_items[0].quantity
     assert_equal 1, cart.line_items[1].quantity
     assert_equal 2, cart.line_items.size
     assert_equal products(:one).price + products(:ruby).price, cart.total_price
  end

  test "空的購物車中加入兩個相同商品，驗證購物車中品項數目、該商品總數及總金額" do
     cart = Cart.create
     cart.add_product(products(:ruby)).save!
     cart.add_product(products(:ruby)).save!
     assert_equal 2, cart.line_items[0].quantity
     assert_equal 1, cart.line_items.size
     assert_equal products(:ruby).price * 2, cart.total_price
  end
end
