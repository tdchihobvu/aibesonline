class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :phone_number
      t.string :random_pass
      t.boolean :is_active, :default => false

      t.timestamps
    end
  end
end
