class TasksController < ApplicationController
  before_action :authorize
  before_action :current_project, except: [:destroy]
  before_action :current_task, only: [:edit, :update, :destroy]

  def index
    @new_task = @project.tasks.build
  end

  def new; end

  def create 
    task = @project.tasks.build(task_params)

    if task.save
      redirect_to project_tasks_path
    else
      render action: :index, locals: { :@tasks => @project.tasks, :@task => task }
    end
  end

  def edit; end

  def update
    if @task.update_attributes(task_params)
      redirect_to project_tasks_path(@project)
    else
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to action: :index, status: 303 }
      format.js   { head :ok }
    end
  end

  private
  def current_task
    @task = Task.find(params[:id])
  end

  def current_project
    @project = Project.find(params[:project_id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :state,
                                 :estimated_time, :time_spent, 
                                 :deadline, :project_id)
  end
end
