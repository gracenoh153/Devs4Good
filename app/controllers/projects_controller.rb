class ProjectsController < ApplicationController
  before_action :require_login, only: [:new]

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    p current_user
    if current_user.user_type == 'dev'
      redirect_to :root
    end
    @project = Project.new
  end

  def create
    @project = Project.create(project_params)
    if @project.save
      redirect_to project_path(@project)
    else
      render new_project_path
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
  end




private
  def project_params
    params.require(:project).permit(:title, :description, :time_frame)
  end
end
