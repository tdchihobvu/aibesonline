class CreateCustomerOrders < ActiveRecord::Migration
  def change
    create_table :customer_orders do |t|
      t.string :order_no
      t.string :customer_name
      t.string :address_line1
      t.string :address_line2
      t.string :city
      t.string :mobile_no
      t.string :email
      t.integer :payment_gateway_id
      t.boolean :delivery, :default => false
      t.boolean :paid, :default => false
      t.boolean :processed, :default => false
      t.boolean :collected, :default => false

      t.timestamps
    end
  end
end
