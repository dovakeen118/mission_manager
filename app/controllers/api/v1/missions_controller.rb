class Api::V1::MissionsController < ApplicationController
  def index
    render json: Mission.all
  end

  def show
    render json: Mission.find(params[:id])
  end
end
