class Api::V1::MissionsController < ApplicationController
  def create
    if user_signed_in?
      mission = Mission.new(new_mission_params)
      mission.user = current_user

      if mission.save
        render json: mission
      else
        render json: { errors: mission.errors.full_messages}
      end
    else
      render json: { invalid: true }
    end
  end

  def index
    render json: Mission.all
  end

  def show
    render json: Mission.find(params[:id])
  end

  private

  def new_mission_params
    params.require(:mission).permit(:title, :description)
  end
end
