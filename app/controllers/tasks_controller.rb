class TasksController < ApplicationController
  def index
    @tasks = case params[:sort]
    when "name"
        Task.where(completed: false).order(:subject)
    when "oldest"
        Task.where(completed: false).order(:created_at)
    else # "due" またはパラメータが無い場合はデフォルト(期限順)
        Task.where(completed: false).order(
        Arel.sql("CASE WHEN deadline < '#{Time.zone.today}' THEN 1 ELSE 0 END"),
        :deadline
        )
    end
  end
  def edit
      @task = Task.find(params[:id])
  end


  def new
    @task = Task.new
  end

  def main
    @tasks = Task.where(completed: false).order(
        Arel.sql("CASE WHEN deadline < '#{Time.zone.today}' THEN 1 ELSE 0 END"),
        :deadline
    )
    @overdue_tasks = Task.where(completed: false).where("deadline < ?", Time.zone.today)
    @today_tasks = Task.where(completed: false, deadline: Time.zone.today)
    @tomorrow_tasks = Task.where(completed: false, deadline: Time.zone.today + 1)
    @two_days_tasks = Task.where(completed: false, deadline: Time.zone.today + 2)
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

        if @task.update(task_params)
            redirect_to tasks_path, notice: "更新しました！"
        else
            render :edit, status: :unprocessable_entity
        end
    end

  def completed
    @tasks = Task.where(completed: true).order(:deadline)
  end

  private

  def task_params
    params.require(:task).permit(:subject, :title, :content, :deadline, :completed)
  end
  
end