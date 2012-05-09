class UserMailer < ActionMailer::Base
  default from: "notifications@prepared.ly"

  def welcome_email(user)
  	@user 				= user
  	@url 					= "http://prepared.ly/users/sign_in"
  	@referral_url	= "http://www.prepared.ly/?ref=<%= @referral_code %>"
  	@survey = "http://bit.ly/preparedlysurvey"
  	attachments.inline['preparedly-red.png'] = File.read('app/assets/images/preparedly-red.png')
  	mail(:to => user.email, :subject => "Welcome to Prepared.ly")
  end
end
