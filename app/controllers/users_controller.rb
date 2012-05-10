class UsersController < ApplicationController
	
	def get
	 	@user = current_user
	end

	def update
		@user = current_user
		@count = @user.sign_in_count
		prev_email = @user.email
		@user.update_attributes(params[:user])
		# send welcome email to Twitter user who updates their email at signup
		# or other oauth user who is asked to add a phone number at registration
		if prev_email == "change@changeme.com" || @count == 1
    	referral_id = 123456789 + current_user.id
    	@referral_code = referral_id.to_s(36)
    	current_user.share_code = @referral_code
    	current_user.save!
			@user.send_welcome_email
		end
		redirect_to share_path, :flash => { :success => "Profile updated." }
	end
end
