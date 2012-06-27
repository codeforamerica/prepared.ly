require 'twilio-ruby'

class Message < ActiveRecord::Base
	attr_accessible :body, :scheduled_time

	def send_message
		@client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])	
		User.where("sms_opt_in = true AND phone != '' AND phone IS NOT null").each do |user|	
      if self.scheduled_time == nil
        begin
          @client.account.sms.messages.create(	
          :from => '+15128616101', 	
          :to => user.phone,
          :body => self.body
          )
          self.sent = true
          self.save!
        rescue Exception => e
          logger.debug "Unable to send sms message to " + user.phone
          logger.debug e
        end
      end
		end
	end

  def send_scheduled_messages(user)
		@client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])	
		User.where("sms_opt_in = true AND phone != '' AND phone IS NOT null").each do |user|	
      Message.where("(sent IS null OR sent = false) AND scheduled_time < ?", Time.now).each do |message|
        begin
          @client.account.sms.messages.create(	
          :from => '+15128616101', 	
          :to => user.phone,
          :body => message.body
          )
          message.sent = true
          message.save!
        rescue Exception => e
          logger.debug "Unable to send sms message to " + user.phone
          logger.debug e
        end
      end
		end
  end

	after_create :send_message
end
