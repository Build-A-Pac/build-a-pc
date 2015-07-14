class ComputersController < ApplicationController
  def create
    @computer = Computer.new(computer_name: params[:computer_name])

    if @computer.save
      render json: { computer: @computer.as_json }
    else
      render json: { errors: @images.errors.full_message },
      status: :not_found
    end
  end
end
