class ShareController < ApplicationController
    def index
        referral_id = 123456789 + current_user.id
        @referral_code = referral_id.to_s(36) 
        # not sure why share_code throws an error here - need to migrate db maybe?
        # current_user.share_code = @referral_code
        current_user.save!
    end
end
