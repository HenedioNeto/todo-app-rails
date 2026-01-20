class TaskListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task_list, only: [:show, :edit, :update, :destroy]

  def index
    if user_signed_in?
      @task_lists = current_user.task_lists.includes(:tasks)
    else
      redirect_to new_user_session_path
    end
  end

  def new
    @task_list = current_user.task_lists.new
  end

  def edit
  end

  def create
    @task_list = current_user.task_lists.new(task_list_params)
    
    if @task_list.save
      redirect_to @task_list
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @task_list.update(task_list_params)
      redirect_to @task_list, notice: "Lista atualizada com sucesso!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task_list.destroy
    redirect_to task_lists_url, notice: "Lista removida com sucesso!"
  end
  
  private
  
  def set_task_list
    @task_list = current_user.task_lists.find(params[:id])
  end
  
  def task_list_params
    params.require(:task_list).permit(:title, :description)
  end
end
