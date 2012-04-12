class User < ActiveRecord::Base
	# many ways to authenticate into a single user account, so authentication and identity are separate
	has_many :authentications

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :first_name, :last_name, :phone, :address,
    :preferred_contact, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
end
