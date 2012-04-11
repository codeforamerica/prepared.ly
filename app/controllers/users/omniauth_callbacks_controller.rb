class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter

    # You need to implement the method below in your model
    user = current_user || User.find_or_create_by_email_and_twitter_uid(email, name, twitter_uid)

    if user.persisted?
      user.update_twitter_uid(twitter_uid)
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Twitter"
      sign_in_and_redirect user, :event => :authentication
    else
      session["devise.twitter_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end



