class LineItem < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :product, optional: true
  belongs_to :cart

  def total_price
    self.price * self.quantity
  end

  # 增加商品數量
  def increase_quantity
    self.quantity += 1
    self
  end

  # 減少商品數量
  def decrease_quantity
    if self.quantity > 1
      self.quantity -= 1
    else
      self.destroy
    end
    self
  end

  # 重新確認商品價格
  def check_price
    if self.price != self.product.price
      self.price = self.product.price 
      self.save
    end      
  end
end
