class AddFToUser < ActiveRecord::Migration
  def change
    add_column :users, :registered, :boolean, :default => false
    add_column :users, :manager, :boolean, :default => false
  end
end
