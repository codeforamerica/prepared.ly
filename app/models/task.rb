class Task < ActiveRecord::Base
  attr_accessible :difficulty, :task, :fact, :detail
  has_many :users
  has_many :completed_tasks

  def self.random
  	ids = connection.select_all("SELECT id from tasks")
  	find(ids[rand(ids.length)]["id"].to_i) unless ids.blank?
  end
end
