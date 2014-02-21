class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :product_id, :null => false, :options => "CONSTRAINT fk_line_item_products REFERENCES products(id)"
      t.integer :customer_order_id, :null => false, :options => "CONSTRAINT fk_line_item_customer_orders REFERENCES customer_orders(id)"
      t.integer :quantity, :null => false

      t.decimal :total_price, :null => false, :precision => 8, :scale => 2, :default => 0.00

      t.string  :ipaddress
      t.string  :location

      t.timestamps
    end
  end
end
