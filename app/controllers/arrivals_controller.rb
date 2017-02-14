class ArrivalsController < ApplicationController
  def get_arrivals
    station = params[:station]
    direction = params[:direction]

    render json: Arrival.get_from_station_and_direction(station, direction), status: 200

  rescue Exception => e
    render json: { message: e.message, stacktrace: e.backtrace }, status: 402
  end

  def go_to_work
    render json: Arrival.go_to_work, status: 200
  end

  def go_home
    render json: Arrival.go_home, status: 200
  end
end
