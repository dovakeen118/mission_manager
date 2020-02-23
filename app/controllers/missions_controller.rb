class MissionsController < ApplicationController
  before_action :set_mission, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index]

  def new
    @mission = Mission.new
  end

  def create
    @mission = Mission.new(new_mission_params)
    @mission.user = current_user

    if @mission.save
      redirect_to @mission, notice: "Mission was successfully created!"
    else
      render :new
    end
  end

  def index
    @missions = Mission.all
  end

  def show
  end

  def edit
    if current_user.id != @mission.user_id
      redirect_to @mission, notice: 'You are not authorized to edit this mission!'
    end
  end

  def update
    if @mission.update(new_mission_params)
      redirect_to @mission, notice: "Mission was successfully updated!"
    else
      render :edit
    end
  end

  def destroy
    if current_user.id != @mission.user_id
      redirect_to @mission, notice: 'You are not authorized to delete this mission!'
    else
      @mission.destroy
      redirect_to missions_url, notice: "Mission was successfully deleted!"
    end
  end

  private

  def set_mission
    @mission = Mission.find(params[:id])
  end

  def new_mission_params
    params.require(:mission).permit(:title, :description)
  end
end
