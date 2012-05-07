class Users::RegistrationsController < Devise::RegistrationsController
    def create
      super()
      current_user.referral_code = request.env['affiliate.tag']
      current_user.save!
      # don't send welcome email when Twitter sign up creates temporary email
      unless current_user.email == "change@changeme.com"
      	current_user.send_welcome_email
      end
    end

    def after_sign_up_path_for(resource)
      "/share"
    end
end