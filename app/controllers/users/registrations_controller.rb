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
    share_path
  end

  # PUT /resource
  # We need to use a copy of the resource because we don't want to change
  # the current user in place.
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)

    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
    params[:user].delete(:current_password) if params[:user][:current_password].blank?

    if resource.update_attributes(params[resource_name])
      if is_navigational_format?
        if resource.respond_to?(:pending_reconfirmation?) && resource.pending_reconfirmation?
          flash_key = :update_needs_confirmation
        end
        set_flash_message :notice, flash_key || :updated
      end
      sign_in resource_name, resource, :bypass => true
      respond_with resource, :location => after_update_path_for(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end
end
