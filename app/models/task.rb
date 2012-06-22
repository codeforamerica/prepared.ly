require 'twilio-ruby'

class Task < ActiveRecord::Base
  attr_accessible :difficulty, :task, :fact, :detail
  has_many :users

  # def send_reminder_email(user, date)
  #   TaskMailer.delay(:run_at => date).reminder_email({:user => user, :task => self})
  # end
  # #handle_asynchronously :send_reminder_email, :run_at => Proc.new { 5.minutes.from_now }

  # def send_reminder_text(user, date)
  #   @client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']) 
  #     @client.account.sms.messages.delay(:run_at => date).create(  
  #      :from => '+15128616101',
  #      :to => user.phone,
  #      :body => 'This is your Prepared.ly reminder to:' + self.task
  #      )
  # end


  def self.random
  	ids = connection.select_all("SELECT id from tasks")
  	find(ids[rand(ids.length)]["id"].to_i) unless ids.blank?
  end
end
