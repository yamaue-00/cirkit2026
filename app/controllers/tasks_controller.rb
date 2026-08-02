class TasksController < ApplicationController
  def index
    @tasks = case params[:sort]
    when "name"
        Task.where(completed: false).order(:subject)
    when "oldest"
        Task.where(completed: false).order(:created_at)
    else # "due" またはパラメータが無い場合はデフォルト(期限順)
        Task.where(completed: false).order(
        Arel.sql("CASE WHEN deadline < '#{Date.today}' THEN 1 ELSE 0 END"),
        :deadline
        )
    end
  end

  def new
    @task = Task.new
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

  def update
    @task = Task.find(params[:id])
    @task.update(completed: true)
    redirect_to tasks_path, notice: "課題完了！"
  end

  def completed
    @tasks = Task.where(completed: true).order(:deadline)
  end

  private

  def task_params
    params.require(:task).permit(:subject, :title, :content, :deadline)
  end
end