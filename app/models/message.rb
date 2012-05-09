require 'twilio-ruby'

class Message < ActiveRecord::Base
	attr_accessible :body

	def send_message
		@client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])	
		User.where(:sms_opt_in => true).find(:all, :conditions => "phone != ''").each do |user|	
      begin
        @client.account.sms.messages.create(	
        :from => '+15128616101', 	
        :to => user.phone,
        :body => self.body
        )
      rescue Exception => e
        logger.debug "Unable to send sms message to " + user.phone
        logger.debug e
      end
		end
	end

	after_create :send_message  	
end
