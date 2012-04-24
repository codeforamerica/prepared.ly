class UsersController < ApplicationController
	
	def get
	 	@user = current_user
	end

	def update
		@user = current_user	
		@user.update_attributes(params[:user])
		redirect_to share_path, :flash => { :success => "Profile updated." }
	end
end
