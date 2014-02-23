class UserRequest < ActiveRecord::Base
  attr_accessible :message, :mobile_no, :notify_me, :username, :email

  validates :username, :presence => true
  validates :message, :presence => true
  
end
