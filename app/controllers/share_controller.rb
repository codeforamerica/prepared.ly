class ShareController < ApplicationController
    def index
        referral_id = 123456789 + current_user.id
        @referral_code = referral_id.to_s(36) 
    end
end
