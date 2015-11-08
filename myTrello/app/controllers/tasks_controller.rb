class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @tasks = Task.all
    @available_tasks = Task.where("due_date > ? AND finished = ?", Date.today, false).order("due_date desc")
    @overdue_tasks = Task.where("due_date < ? AND finished = ?", Date.today, false).order("due_date desc")
    @finished_tasks = Task.where("finished = ?", true).order("due_date desc")
    
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
