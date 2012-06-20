class CompletedTask < ActiveRecord::Base
  attr_accessible :completed, :remind, :task_id, :user_id
  belongs_to :task
  belongs_to :user
end
