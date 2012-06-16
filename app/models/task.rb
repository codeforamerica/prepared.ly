class Task < ActiveRecord::Base
  attr_accessible :difficulty, :task, :fact, :detail
  has_many :users

  def send_reminder_email(user, date)
    TaskMailer.delay(:run_at => date).reminder_email({:user => user, :task => self})
  end
  #handle_asynchronously :send_reminder_email, :run_at => Proc.new { 5.minutes.from_now }


  def self.random
  	ids = connection.select_all("SELECT id from tasks")
  	find(ids[rand(ids.length)]["id"].to_i) unless ids.blank?
  end
end
