class User < ActiveRecord::Base
# to have many ways to authenticate into a single user account, add this line and a related controller and model
  has_many :authentications
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :first_name, :last_name, :phone, :address,
  :preferred_contact, :password, :password_confirmation, :remember_me,
  :provider, :twitter_id, :twitter_screen_name, :twitter_display_name
  # attr_accessible :title, :body
  
  # find twitter user from oauth hash or create if nonexistent; twitter hash does not return email
  def self.find_for_twitter_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = User.where(:provider => data["provider"]).first
      user
    else # Create a user with a stub password
      User.create!(:provider => data["provider"], :twitter_id => data["user_id"], :twitter_screen_name => data["nickname"], :twitter_display_name => data["name"], :password => Devise.friendly_token[0,20]) 
    end
  end
  
  # authenticate using google or google apps account
  def self.find_for_open_id(access_token, signed_in_resource=nil)
    data = access_token.info
    if user = User.where(:email => data["email"]).first
      user
    else # Create a user with a stub password.
      User.create!(:email => data["email"], :provider => data["provider"], :password => Devise.friendly_token[0,20])
    end
  end

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = self.find_by_email(data.email)
      user
    else # Create a user with a stub password. 
      self.create!(:email => data.email, :password => Devise.friendly_token[0,20]) 
    end
  end
end