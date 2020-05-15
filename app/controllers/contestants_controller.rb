class ContestantsController < ApplicationController
  def index
    @contestants = Contestant.all
  end

  def create
    contestant = Contestant.create(allow_params)
    contestant_project = ContestantProject.create({
      contestant_id: "#{contestant.id}",
      project_id: "#{params[:project_id]}"})
    redirect_to "/projects/#{params[:project_id]}"
    end

  private

  def allow_params
    params.permit(:name, :age, :hometown, :years_of_experience)
  end


end
