require 'twilio-ruby'

class Message < ActiveRecord::Base
	attr_accessible :body, :scheduled_time, :user_id, :reminder_type
  belongs_to :user 

	def send_message
		@client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])	
		User.where("sms_opt_in = true AND phone != '' AND phone IS NOT null").each do |user|	
      if self.scheduled_time == nil
        begin
          @client.account.sms.messages.create(	
          #jm sandbox number 
          :from => '+15128616032',
          #at number
          #:from => '+15128616101',  	
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

  def self.send_scheduled_messages()
		@client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])	
    Message.where("(sent IS null OR sent = false) AND reminder_type = 'text' AND scheduled_time < ?", Time.now).each do |message|
      begin
        #user = User.find(:user_id)
        @client.account.sms.messages.create(	
        #jm sandbox number 
        :from => '+15128616032',
        #at number
        #:from => '+15128616101', 	
        :to => message.user.phone,
        :body => message.body
        )
        message.sent = true
        message.save!
      rescue Exception => e
        logger.debug "Unable to send sms message to "  
        logger.debug e
      end
    end
    # call the actionmailer here
    Message.where("(sent IS null OR sent = false) AND reminder_type = 'email' AND scheduled_time < ?", Time.now).each do |message|
      begin
        UserMailer.reminder_email(message.user).deliver 
        message.sent = true
        message.save!
      rescue Exception => e
        logger.debug "Unable to send sms message to "  
        logger.debug e
      end
    end

  end

	after_create :send_message
end
