class EtasController < ApplicationController
  def index
    station = params[:station]
    direction = params[:direction]
    train_line = params[:train_line]

    render json: Arrivals.get_arrivals_for_destination(station, direction, train_line), status: 200
  end
end
