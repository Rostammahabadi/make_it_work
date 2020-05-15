class ProjectsController < ApplicationController
  def index
    @projects = Projects.all
  end

  def show
    @project = Project.find(params[:id])
  end
end
