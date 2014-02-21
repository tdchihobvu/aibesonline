class AddPostedOnToCustomerOrder < ActiveRecord::Migration
  def change
    add_column :customer_orders, :posted_on, :date
  end
end
