class TasksController < ApplicationController
  def index
    @task = Task.new
    @tasks = Task.all
  end

  def new
    @task = Task.new
    @tasks = Task.all
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_path, notice: "追加完了！！"
    else
      @tasks = Task.all
      render :new, status: :unprocessable_entity
    end
  end

  private

  def task_params
    params.require(:task).permit(:subject, :title, :content, :deadline)
  end
end
