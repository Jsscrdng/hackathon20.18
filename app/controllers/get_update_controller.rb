class GetUpdateController < ApplicationController
  def index
    render json: {text: "you're in"}, status :not_found
  end
end
