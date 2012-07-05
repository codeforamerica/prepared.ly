class CommentsController < ApplicationController
	def create
    @task = Task.find(params[:task_id])
    @comment = @task.comments.create(params[:comment])
    redirect_to task_path(@task)
  end
end
