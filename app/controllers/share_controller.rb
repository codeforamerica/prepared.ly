class ShareController < ApplicationController
    def index
    # user's share code is generated in the create action of registrations_controller.rb for regular signups
    # or in the users_controller.rb for oauth users so it's saved to the user before the welcome email goes
	    @share_code = current_user.share_code
    end
end
