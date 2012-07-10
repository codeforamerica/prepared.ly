class Contact < ActiveRecord::Base
  attr_accessible :body, :email, :name, :contact_type
end
