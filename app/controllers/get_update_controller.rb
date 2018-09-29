class GetUpdateController < ApplicationController
  def index
    render json: {message: "you're in"}
  end
end
