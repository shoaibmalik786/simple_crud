class ProjectsController < ApplicationController
  before_action :fetch_project, except: [:index, :new, :create]

  def index
    @projects = current_user.projects
  end

  def new
    @project = Project.new
  end

  def create
    project = current_user.projects.new(project_params)
    if project.save
      flash[:notice] = 'Project successfully created'
      redirect_to projects_path
    else
      flash[:error] = project.errors.full_messages.compact * ' and '
      redirect_to new_project_path
    end
  end

  def update
    if @project.update(project_params)
      flash[:notice] = 'Project successfully updated'
      redirect_to projects_path
    else
      flash[:error] = @project.errors.full_messages.compact * ' and '
      redirect_to edit_project_path(@project)
    end
  end

  def destroy
    if @project.destroy
      flash[:notice] = 'Project successfully deleted'
    else
      flash[:notice] = 'Unable to delete this project'
    end
    redirect_to projects_path
  end

  private

  def fetch_project
    @project = current_user.projects.find_by(id: params[:id])
    if @project.nil?
      flash[:error] = 'Project not found'
      redirect_to root_path
      return
    end
  end

  def project_params
    params.require(:project).permit(:name)
  end
end

