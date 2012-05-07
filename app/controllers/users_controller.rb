class UsersController < ApplicationController
	
	def get
	 	@user = current_user
	end

	def update
		@user = current_user
		prev_email = @user.email
		@user.update_attributes(params[:user])
		# send welcome email to Twitter user who updates their email at signup
		if prev_email == "change@changeme.com" && @user.email != "change@changeme.com" 
			@user.send_welcome_email
		end
		redirect_to share_path, :flash => { :success => "Profile updated." }
	end
end
