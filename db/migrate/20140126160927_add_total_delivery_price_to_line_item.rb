class AddTotalDeliveryPriceToLineItem < ActiveRecord::Migration
  def change
    add_column :line_items, :total_delivery_price, :decimal
  end
end
