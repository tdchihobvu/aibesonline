class AddDeliveryPriceToProduct < ActiveRecord::Migration
  def change
    add_column :products, :delivery_price, :decimal, :default => 0.00, :precision => 8, :scale => 2
  end
end
