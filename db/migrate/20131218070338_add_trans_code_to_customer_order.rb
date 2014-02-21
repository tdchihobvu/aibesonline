class AddTransCodeToCustomerOrder < ActiveRecord::Migration
  def change
    add_column :customer_orders, :trans_code, :string
  end
end
