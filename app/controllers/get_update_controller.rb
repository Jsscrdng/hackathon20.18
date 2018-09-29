class GetUpdateController < ApplicationController
  def index
    render json: {text: "you're in"}
  end
end
