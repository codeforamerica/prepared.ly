class Users::RegistrationsController < Devise::RegistrationsController
    def create
        super()
        current_user.referral_code = request.env['affiliate.tag']
        current_user.save!
    end

    def after_sign_up_path_for(resource)
      @user = current_user
      unless @user.email == "change@changeme.com"
      	@user.send_welcome_email
      end
      "/share"
    end
end