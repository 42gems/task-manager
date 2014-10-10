class ProjectsController < ApplicationController
  before_action :current_project, only: [:edit, :update, :destroy]

  def index
    @projects = current_user.projects.all
    @project = current_user.projects.build
  end

  def new; end

  def create
    project = current_user.projects.build(project_params)

    if project.save
      redirect_to projects_path
    else
      render action: :index, locals: { :@projects => Project.all, :@project => current_user.projects.build }
    end
  end

  def edit
    @members = @project.members
  end

  def update
    if @project.update_attributes(project_params)
      redirect_to projects_path
    else
      render 'edit'
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to action: :index, status: 303 }
      format.js { head :ok }
    end
  end

  def send_invite
    @project = Project.find(params[:project_id])
    @user = User.find(params[:id])
    UserMailer.send_invite(@project, @user)
    @members = @project.members
    render partial: 'members', formats: :html
  end

  def add_member
    @project = Project.find(params[:project_id])
    @project.members << User.find(params[:id])
    redirect_to project_tasks_url(@project)
  end

  def remove_member
    @project = Project.find(params[:project_id])
    @project.members.delete(params[:id])
    respond_to do |format|
      format.html { redirect_to project_tasks_url(@project) }
      format.json {
        render partial: 'select_tag', formats: :html
      }
    end
  end

  private
  def current_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :description)
  end
end
