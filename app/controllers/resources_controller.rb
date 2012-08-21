class ResourcesController < ApplicationController
  def index
  	@user = current_user
  end
  def redflag
  	@user = current_user
  end
end
