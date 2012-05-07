class User < ActiveRecord::Base
# to have many ways to authenticate into a single user account, add this line and a related controller and model
  has_many :authentications
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :first_name, :last_name, :phone, :address, :preferred_contact, :password, :password_confirmation, :remember_me, :provider, :provider_id, :twitter_screen_name, :twitter_display_name, :referral_code

  def self.find_or_create_for_twitter(access_token, signed_in_resource=nil)
    data = access_token
    # search by twitter uid instead of email since user might not have set their email yet
    if user = User.where(:provider_id => data["uid"]).first
      user
    else # create user with stub password; twitter doesn't return email; need a valid email for devise to validate
      user = User.create!(:email => "change@changeme.com", :password => Devise.friendly_token[0,20], :provider => data["provider"], :provider_id => data["uid"], :twitter_screen_name => data.info["nickname"], :twitter_display_name => data.info["name"])
    end
  end

  def self.find_or_create_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token
    if user = User.where(:email => data.info["email"]).first
      user
    else # Create a user with a stub password.
      User.create!(:email => data.info["email"], :password => Devise.friendly_token[0,20], :provider => data["provider"], :provider_id => data["uid"], :first_name => data.info["first_name"], :last_name => data.info["last_name"])
    end
  end

  def self.find_or_create_for_facebook(access_token, signed_in_resource=nil)
    # uncomment line below to see what is returned in the omniauth hash, set value accordingly
    # raise request.env["omniauth.auth"].to_yaml
    data = access_token
    if user = User.where(:email => data.info["email"]).first
      user
    else # Create a user with a stub password.
      User.create!(:email => data.info["email"], :password => Devise.friendly_token[0,20], :provider => data["provider"], :provider_id => data["uid"], :first_name => data.info["first_name"], :last_name => data.info["last_name"])
    end
  end

  def self.find_or_create_for_yahoo(access_token, signed_in_resource=nil)
    # uncomment line below to see what is returned in the omniauth hash, set value accordingly
    # raise request.env["omniauth.auth"].to_yaml
    data = access_token
    if user = User.where(:email => data.info["email"]).first
      user
    else # Create a user with a stub password.
      User.create!(:email => data.info["email"], :password => Devise.friendly_token[0,20], :provider => data["provider"], :provider_id => data["uid"], :first_name => data.info["first_name"], :last_name => data.info["last_name"])
    end
  end

  def send_welcome_email
    UserMailer.welcome_email(self).deliver
  end 

end