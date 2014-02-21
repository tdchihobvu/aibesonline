class PaymentGateway < ActiveRecord::Base
  attr_accessible :name, :provider

  has_many :customer_orders
end
