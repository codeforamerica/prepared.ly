class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
 def twitter
    user = current_user || User.find_for_twitter_oauth(request.env["omniauth.auth"])
    sign_in_and_redirect user, :event => :authentication

  #   if user.persisted?
  #     # user.update_twitter_uid(twitter_uid)
  #     flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Twitter"
  #     sign_in_and_redirect user, :event => :authentication
  #   else
  #     session["devise.twitter_data"] = request.env["omniauth.auth"]
  #     redirect_to new_user_registration_url
  #   end 
  end

   def google
    @user = User.find_for_open_id(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.open:id_data"] = request.env["openid.ext1"]
      redirect_to new_user_registration_url
    end
  end

  def facebook
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end

