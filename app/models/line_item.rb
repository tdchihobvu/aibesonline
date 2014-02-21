class LineItem < ActiveRecord::Base
  attr_accessible :customer_order_id, :ipaddress, :location, :product_id, :quantity, :total_price
  
  belongs_to :customer_order
  belongs_to :product

  def self.from_cart_item(cart_item)
    li = self.new
    li.product = cart_item.product
    li.quantity = cart_item.quantity
    li.total_price = cart_item.price
    li.total_delivery_price = cart_item.delivery_price
    li
  end
end
