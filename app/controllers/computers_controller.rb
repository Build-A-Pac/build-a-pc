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

  def update_computer
    computer = Computer.new
    @computer = computer.create

    part = Part.new
    @part = part.save_part

    @computer_part = ComputerPart.new(part_id: @part.id, computer_id: @computer.id)
  end
end
