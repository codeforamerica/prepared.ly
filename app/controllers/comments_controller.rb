class CommentsController < ApplicationController

	def create
    @task = Task.find(params[:task_id])
    @comment = @task.comments.create(:name => params[:comment][:name], :body => params[:comment][:body], :user_id => current_user.id)
    respond_to do |format|
    	format.html {redirect_to root_path, notice: "Thanks for commenting"}
    	format.js
    end
  end

end
