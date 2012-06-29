class HomeController < ApplicationController
  def index
  	@user = current_user
    unless @user.nil?
      @completed_tasks = CompletedTask.find_all_by_user_id(@user.id) # returns an array
    end
    @random = Task.random
  end
end
