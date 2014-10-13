class ProjectsController < ApplicationController
  before_action :current_project, only: [:edit, :update, :destroy]
  before_action :authorize, only: [:edit, :update, :destroy]

  def index
    project_ids = (current_user.projects.pluck(:id) << current_user.invites.pluck(:project_id)).flatten!
    @projects = Project.where('id IN (?)', project_ids)
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
      format.html {
        unless current_user.can_manage? @project
          render text: root_path
        else
          render text: edit_project_path(@project)
        end
      }
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
