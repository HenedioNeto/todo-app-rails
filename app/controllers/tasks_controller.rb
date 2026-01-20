class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task_list
  before_action :set_task, only: [:edit, :update, :destroy, :toggle]

  def edit
  end

  def create
    @task = @task_list.tasks.new(task_params)
    
    if @task.save
      redirect_to @task_list
    else
      redirect_to @task_list, alert: "Erro ao adicionar tarefa"
    end
  end

  def update
    if @task.update(task_params)
      redirect_to @task_list, notice: "Tarefa atualizada!"
    else
      redirect_to @task_list, alert: "Erro ao atualizar tarefa"
    end
  end

  def destroy
    @task.destroy
    redirect_to @task_list, notice: "Tarefa removida!"
  end

  def toggle
    @task.update(completed: !@task.completed)
    redirect_to @task_list, notice: "Status alterado!"
  end
  
  private
  
  def set_task_list
    @task_list = current_user.task_lists.find(params[:task_list_id])
  end
  
  def set_task
    @task = @task_list.tasks.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:description, :completed, :due_date, :priority, :notes)
  end
end