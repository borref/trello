class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  respond_to :html

  def index
    @tasks = Task.all
    @available_tasks = Task.where("due_date >= ? AND finished = ?", Date.today, false).order("due_date")
    @overdue_tasks = Task.where("due_date < ? AND finished = ?", Date.today, false).order("due_date")
    @finished_tasks = Task.where("finished = ?", true).order("due_date")
    
    respond_with(@tasks)  
  end

  def show
    respond_with(@task)
  end

  def new
    @task = Task.new
    respond_with(@task)
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    @task.save
    respond_with(@task)
  end

  def update
    @task.update(task_params)
    respond_with(@task)
  end

  def destroy
    @task.destroy
    respond_with(@task)
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :description, :duration, :start_date, :due_date, :finished, :user_id)
    end
end
