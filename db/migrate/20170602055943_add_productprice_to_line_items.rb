class AddProductpriceToLineItems < ActiveRecord::Migration[5.0]
  def change
    add_column :line_items, :price, :decimal, precision: 8, scale: 2
  end
  
  def up
    LineItem.all.each do |lineitem|
      # 使用 update_attribute method 即可完成
      lineitem.update_attribute :price, lineitem.product.price
    # 用 lineitem 中的 product_id 找出 product 的 price
    # 並將此 price 存到 lineitem.price 中 
    # 原本使用以下 code 但發現更好的做法
    # product = Product.find(product_id: line_item.product_id)
    # lineitem.price = product.price
    # lineitem.save!
    end
  end

  def down
    # 使用 remove_column method 即可完成
    remove_column :line_items, :price
    # 把所有 lineitem 重新產生一份舊 schema 的資料
    # 並刪除重新產生前的資料
    # 原本使用以下 code 但發現更好的做法
    # LineItem.all.each do |lineitem|
    #   LinItem.creat(
    #     cart_id: line_item.cart_id,
    #     product_id: line_item.product_id,
    #     quantity: line_item.quantity
    #   )
      
    #   lineitem.destroy
    # end
  end
end
