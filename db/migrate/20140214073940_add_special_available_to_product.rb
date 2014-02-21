class AddSpecialAvailableToProduct < ActiveRecord::Migration
  def change
    add_column :products, :special_available, :boolean, :default => false
    add_column :products, :upcoming, :boolean, :default => false
  end
end
