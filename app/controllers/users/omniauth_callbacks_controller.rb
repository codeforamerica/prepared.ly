class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

 def twitter
    @user = User.find_or_create_for_twitter(request.env["omniauth.auth"])
    flash[:notice] = "Signed in with Twitter successfully."
    # use devise-provided method to redirect the user
    if @user.email == "changeme@changeme.com" || @user.phone.blank?
      sign_in @user, :event => :authentication
      redirect_to users_get_path
    else
      sign_in_and_redirect @user, :event => :authentication
     end
  end

   def google_oauth2
    @user = User.find_or_create_for_google_oauth2(request.env["omniauth.auth"])
    flash[:notice] = "Signed in with Google successfully."
    # use devise-provided method to redirect the user
    if @user.phone.blank?
      sign_in @user, :event => :authentication
      redirect_to users_get_path
    else
      sign_in_and_redirect @user, :event => :authentication
     end
  end

  def facebook
    @user = User.find_or_create_for_facebook(request.env["omniauth.auth"], current_user)
    flash[:notice] = "Signed in with Facebook successfully."
    # use devise-provided method to redirect the user
    if @user.phone.blank?
      sign_in @user, :event => :authentication
      redirect_to users_get_path
    else
      sign_in_and_redirect @user, :event => :authentication
     end
  end
end
