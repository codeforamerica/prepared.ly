class HomeController < ApplicationController
  def index
  	@user = current_user
    unless @user.nil?
      @tasks = CompletedTask.find_all_by_user_id(@user.id).map{|task| Task.where(:id => task.task_id).all.map(&:task) }
      @comments = Comment.find_all_by_user_id(@user.id)
    end
    @random = Task.random
    @contact = Contact.new
  end
end


