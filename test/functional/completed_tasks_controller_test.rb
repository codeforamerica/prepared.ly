require 'test_helper'

class CompletedTasksControllerTest < ActionController::TestCase
  setup do
    @completed_task = completed_tasks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:completed_tasks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create completed_task" do
    assert_difference('CompletedTask.count') do
      post :create, completed_task: { completed: @completed_task.completed, remind: @completed_task.remind, task_id: @completed_task.task_id, user_id: @completed_task.user_id }
    end

    assert_redirected_to completed_task_path(assigns(:completed_task))
  end

  test "should show completed_task" do
    get :show, id: @completed_task
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @completed_task
    assert_response :success
  end

  test "should update completed_task" do
    put :update, id: @completed_task, completed_task: { completed: @completed_task.completed, remind: @completed_task.remind, task_id: @completed_task.task_id, user_id: @completed_task.user_id }
    assert_redirected_to completed_task_path(assigns(:completed_task))
  end

  test "should destroy completed_task" do
    assert_difference('CompletedTask.count', -1) do
      delete :destroy, id: @completed_task
    end

    assert_redirected_to completed_tasks_path
  end
end
