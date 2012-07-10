class CommentsController < ApplicationController

	def create
    @task = Task.find(params[:task_id])
    @comment = @task.comments.create(params[:comment])
    respond_to do |format|
    	format.html {redirect_to root_path, notice: "Thanks for commenting"}
    	format.js
    end
  end

end
