class Task < ActiveRecord::Base
  attr_accessible :difficulty, :task, :fact
  has_many :users

  def self.random
  	ids = connection.select_all("SELECT id from tasks")
  	find(ids[rand(ids.length)]["id"].to_i) unless ids.blank?
  end
end
