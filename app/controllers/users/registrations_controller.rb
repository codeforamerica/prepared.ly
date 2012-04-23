class Users::RegistrationsController < Devise::RegistrationsController
    def create
        super()
        current_user.referral_code = request.env['affiliate.tag']
        current_user.save!
    end
end
