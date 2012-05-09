class UserMailer < ActionMailer::Base
  default from: "notifications@prepared.ly"

  def welcome_email(user)
  	@user 					= user
  	@url 						= "http://prepared.ly/users/sign_in"
  	@referral_url		= "http://www.prepared.ly/?ref" + @user.referral_code.to_s
  	@facebook_share = "http://www.facebook.com/sharer.php?u=" + @user.referral_code.to_s
  	@tumblr_share 	= "http://www.tumblr.com/share/link?url=" + @user.referral_code.to_s
  	@twitter_share 	= "http://twitter.com/share?text=Check%20out%20Preparedly&url=" + @user.referral_code.to_s
  	@survey 				= "http://bit.ly/preparedlysurvey"
  	attachments.inline['preparedly-red.png'] = File.read('app/assets/images/preparedly-red.png')
  	mail(:to => user.email, :subject => "Welcome to Prepared.ly")
  end
end
