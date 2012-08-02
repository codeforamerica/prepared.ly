class Contact < ActiveRecord::Base
  attr_accessible :recipient, :body, :email, :name, :contact_type
end
