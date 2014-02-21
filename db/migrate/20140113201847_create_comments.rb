class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :username
      t.text :message
      t.boolean :publish, :default => false

      t.timestamps
    end
  end
end
