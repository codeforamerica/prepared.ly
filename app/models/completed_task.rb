class CompletedTask < ActiveRecord::Base
  attr_accessible :completed, :remind, :task_id, :user_id
end
