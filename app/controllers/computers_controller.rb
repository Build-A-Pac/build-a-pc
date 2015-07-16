class ComputersController < ApplicationController
  def create
    @computer = Computer.new(computer_name: params[:computer_name])

    @part_maodels = params['parts'].map do |part|
      p = part.find_by(name: params['parts']['sku'])
      if p
        render json: { computer: @computer.as_json, parts: p.as_json }
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
