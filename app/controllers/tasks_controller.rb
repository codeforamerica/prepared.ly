class TasksController < ApplicationController
  # GET /tasks
  # GET /tasks.json

  def index
    # @tasks = Task.all
    @random = Task.random
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasks }
    end
  end

  def partial
    @random = Task.random
    render :template => "tasks/_tasks", :layout => false
  end

  # GET /tasks/1
  # GET /tasks/1.json

  def remind
    #sleep 10 # simulate the effect by waiting ten seconds to deliver
    task_id = params[:task_id]
    date = params[:date]
    user = current_user 
    # if params[:email] == "1"
    #   Task.find(task_id).send_reminder_email(user, date)
    # end
    # if params[:text] == "1"
    #   Task.find(task_id).send_reminder_text(user, date)
    # end
    redirect_to tasks_url, notice: "Setting reminder(s)"
  end

  def show
    @task = Task.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @task = Task.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(params[:task])

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render json: @task, status: :created, location: @task }
      else
        format.html { render action: "new" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
    end
  end
end




