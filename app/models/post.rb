class Post < ActiveRecord::Base
  attr_accessible :message, :user_id

  validates :message, :presence => true
  validates :user_id, :presence => true
end
