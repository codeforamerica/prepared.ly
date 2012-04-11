class Authentication < ActiveRecord::Base
  belongs_to :user

  # unnecessary b/c not setting this from the user params
  # attr_accessible :create, :destroy, :index, :provider, :uid, :user_id
end
