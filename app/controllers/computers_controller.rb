class ComputersController < ApplicationController
  def index
  end

  def create
    @computer = Computer.create(computer_name: params[:computer_name])

    @part_maodels = params['parts'].map do |part|
      p = Part.find_by(name: part['name'])
      if p
        p
      else
        Part.create(name: part["sku"], model: part["name"], make: part["manufacturer"],
                    category: part["categoryPath"], cost: part["salePrice"], store_url: part['url'],
                    details: part["details"])
      end
    end

    @computer.parts = @part_maodels
    render json: { computer: @computer.as_json, parts: @computer.parts.as_json }
  end

  def show
    @computer = Computer.find(params[:id])
    render json: { computer: @computer.as_json, parts: @computer.parts.as_json }
  end
end



# name: part["name"], model: part["model"]
