class IssuesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :add_comment
  before_action :fetch_project
  before_action :fetch_issue, only: [:edit, :update, :destroy, :add_comment]

  def new
    @issue = Issue.new
  end

  def create
    issue = @project.issues.new(issue_params)
    if issue.save
      flash[:notice] = 'Issue successfully created'
      redirect_to project_path(@project)
    else
      flash[:error] = issue.errors.full_messages.compact * ' and '
      redirect_to new_project_issue_path(@project)
    end
  end

  def update
    if @issue.update(issue_params)
      flash[:notice] = 'Issue successfully updated'
      redirect_to project_path(@project)
    else
      flash[:error] = @issue.errors.full_messages.compact * ' and '
      redirect_to edit_project_issue_path(@project, @issue)
    end
  end

  def destroy
    @issue.destroy
    flash[:notice] = 'Issue successfully deleted'
    redirect_to project_path(@project)
  end

  def add_comment
    @comment = @issue.comments.create(comments_params.merge(user_id: current_user.id))
    render json: {description: @comment.description, date: @comment.created_at.strftime("%Y-%m-%d %H:%M")}
  end

  private

  def fetch_project
    @project = current_user.projects.find_by(id: params[:project_id])
    if @project.nil?
      flash[:error] = 'Project not found'
      redirect_to root_path
      return
    end
  end

  def fetch_issue
    @issue = @project.issues.find_by(id: params[:id])
    if @issue.nil?
      flash[:error] = 'Issue not found'
      redirect_to root_path
      return
    end
  end

  def comments_params
    params.require(:comment).permit(:description)
  end

  def issue_params
    params[:issue][:status] = params[:issue][:status].to_i if params[:issue][:status].present?
    params.require(:issue).permit(:title, :assign_to, :status, :description)
  end
end

