class AddEmailToUserRequest < ActiveRecord::Migration
  def change
    add_column :user_requests, :email, :string
  end
end
