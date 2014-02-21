class UserRequest < ActiveRecord::Base
  attr_accessible :message, :mobile_no, :notify_me, :username

  validates :username, :presence => true
  validates :message, :presence => true
  
end
