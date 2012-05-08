require 'twilio-ruby'

class Message < ActiveRecord::Base
	attr_accessible :body

	def send_message
		@client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])	
		User.find(:all, :conditions => "phone != ''").each do |user|	
			@client.account.sms.messages.create(	
			:from => '+15128616101', 	
			:to => user.phone,
			:body => self.body
			)
		end
	end

	after_create :send_message  	
end