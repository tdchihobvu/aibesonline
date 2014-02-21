class CreateUserRequests < ActiveRecord::Migration
  def change
    create_table :user_requests do |t|
      t.string :username
      t.text :message
      t.boolean :publish, :default => false
      t.boolean :notify_me, :default => false
      t.string :mobile_no

      t.timestamps
    end
  end
end
