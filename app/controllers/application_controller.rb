class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    render json: 'welcome to bart lite. for instructions on how to use bart lite, visit: https://github.com/cgardens/bart_lite'
  end
end
