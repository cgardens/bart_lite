class ValidStationCodesController < ApplicationController
  def index
    render json: ValidStationCodes.new.get_valid_station_codes, status: 200
  end
end
