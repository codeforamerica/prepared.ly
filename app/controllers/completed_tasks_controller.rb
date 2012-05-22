class CompletedTasksController < ApplicationController
  # GET /completed_tasks
  # GET /completed_tasks.json
  def index
    @completed_tasks = CompletedTask.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @completed_tasks }
    end
  end

  # GET /completed_tasks/1
  # GET /completed_tasks/1.json
  def show
    @completed_task = CompletedTask.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @completed_task }
    end
  end

  def completed
    @user = current_user
    task_id = session[:task_id]
    unless CompletedTask.exists?(:user_id => current_user.id, :task_id => task_id, :completed => TRUE)
      CompletedTask.create!(:user_id => current_user.id, :task_id => task_id, :completed => TRUE)
    end

    redirect_to tasks_path
  end

  # GET /completed_tasks/new
  # GET /completed_tasks/new.json
  def new
    # if user_signed_in?
    #   @user = current_user
    #   @findrandom = Task.find(params[:id])
    #   @completed_task = CompletedTask.create!(:user_id => @user.user_id, :task_id => @findrandom, :completed => yes)
    #     #will the created_at and updated_at get populated automatically in the new completed task?
    # else
    #   redirect_to(new_user_registration_path)
    # end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @completed_task }
    end
  end

  # GET /completed_tasks/1/edit
  def edit
    @completed_task = CompletedTask.find(params[:id])
  end

  # POST /completed_tasks
  # POST /completed_tasks.json
  def create
    @completed_task = CompletedTask.new(params[:completed_task])

    respond_to do |format|
      if @completed_task.save
        format.html { redirect_to @completed_task, notice: 'Completed task was successfully created.' }
        format.json { render json: @completed_task, status: :created, location: @completed_task }
      else
        format.html { render action: "new" }
        format.json { render json: @completed_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /completed_tasks/1
  # PUT /completed_tasks/1.json
  def update
    @completed_task = CompletedTask.find(params[:id])

    respond_to do |format|
      if @completed_task.update_attributes(params[:completed_task])
        format.html { redirect_to @completed_task, notice: 'Completed task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @completed_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /completed_tasks/1
  # DELETE /completed_tasks/1.json
  def destroy
    @completed_task = CompletedTask.find(params[:id])
    @completed_task.destroy

    respond_to do |format|
      format.html { redirect_to completed_tasks_url }
      format.json { head :no_content }
    end
  end
end
