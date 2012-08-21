class ResourcesController < ApplicationController
  def index
  	@user = current_user
  end
  def alert
  	@user = current_user
  end
end
