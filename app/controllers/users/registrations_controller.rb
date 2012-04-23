class Users::RegistrationsController < Devise::RegistrationsController
    def create
        super()
        current_user.last_name = request.env['affiliate.tag']
        current_user.save!
    end
end
