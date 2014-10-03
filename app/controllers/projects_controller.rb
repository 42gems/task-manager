class ProjectsController < ApplicationController
  before_action :current_project, only: [:edit, :update, :destroy]

  def index
    @projects = Project.all
    @project = current_user.projects.build
  end

  def new; end

  def create
    title       =  params[:project][:title]
    description =  params[:project][:description]
    project = current_user.projects.build(title: title, description: description)

    if project.save
      redirect_to projects_path
    else
      render text: 'new'
    end
  end

  def edit; end

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

  private
  def current_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:product).permit(:title, :description)
  end
end
