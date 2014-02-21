class Comment < ActiveRecord::Base
  attr_accessible :message, :publish, :username

  def self.published_comments
    find_all_by_publish(true, :limit => 5)
  end
end
