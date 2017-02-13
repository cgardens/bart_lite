class ArrivalsController < ApplicationController
  def go_to_work
    render json: Arrival.go_to_work, status: 200
  end

  def go_home
    render json: Arrival.go_home, status: 200
  end
end
