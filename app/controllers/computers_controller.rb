class ComputersController < ApplicationController
  def create
    @computer = Computer.new(computer_name: params[:computer_name])

    @part_maodels = params[:parts].map do |part|
      p = Part.find_by(sku: params[:parts].name)
      if p
        render json: { part: p.as_json }
      else
        @thing = Part.create(name: params["sku"], make: params["manufacturer"],
                         model: params["name"], category: params["categoryPath"],
                         cost: params["salePrice"], store_url: params["url"])
        render json: { part: @thing.as_json }
      end
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
