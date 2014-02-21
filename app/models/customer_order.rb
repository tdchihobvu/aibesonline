class CustomerOrder < ActiveRecord::Base
  attr_accessible :address_line1, :address_line2, :city, :collected, :customer_name, :delivery, :email, :mobile_no, :order_no, :paid, :payment_gateway_id, :processed

  belongs_to :payment_gateway
  has_many :line_items, :dependent => :destroy

  scope :unpaid_orders, :order => 'created_at ASC', :conditions => { :paid => false }
  scope :unprocessed_orders, :order => 'created_at ASC', :conditions => { :paid => true, :processed => false }
  
  validates :customer_name, :presence => true
  validates :payment_gateway_id, :presence => true
  validates :mobile_no, :presence => true
  validates_numericality_of :mobile_no
  validate :delivery_require_address
  
  def add_line_items_from_cart(cart)
    cart.items.each do |item|
    li = LineItem.from_cart_item(item)
    line_items << li
    end
  end

  def reduce_quantity_sold(customer_order)
    customer_order.line_items.each do |i|
      product = Product.find(i.product_id)
      qty = product.quantity - i.quantity
      product.update_attribute(:quantity, qty)
    end
  end

  def self.uncollected_orders
    find_all_by_paid_and_processed_and_delivery_and_collected(true, true, false, false, :order => 'updated_at ASC')
  end

  def self.undelivered_orders
    find_all_by_paid_and_processed_and_delivery_and_collected(true, true, true, false, :order => 'updated_at ASC')
  end

  def paid_status
    return "YES" if paid == true
    return "No" if paid == false
  end

  def order_status
    return "Collection" if delivery == false
    return "Delivery" if delivery == true
  end

  def processed_status
    return "YES" if processed == true
    return "No" if processed == false
  end

  private

  def delivery_require_address
    errors.add(:address_line1," cannot be left blank, if you want your items to be delivered.") if address_line1.blank? and delivery == 1
  end
  
end
