class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :task
  attr_accessible :name, :body, :user_id
end
