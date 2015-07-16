class PartsController < ApplicationController

  def save_part
    @part = Part.new(name: params["sku"], make: params["manufacturer"],
                     model: params["name"], category: params["categoryPath"],
                     cost: params["salePrice"], store_url: params["url"])
    if Part.find_or_create_by(name: @part.name)
      render json: { part: @part.asjson }
    else
      render json: { errors: @part.errors.full_message },
      status: :not_found
    end
  end

  Part.find_or_create_by(name: params["sku"], make: params["manufacturer"],
                   model: params["name"], category: params["categoryPath"],
                   cost: params["salePrice"], store_url: params["url"])

  # def computer
  #   @computer = Computer.new(computer_name: params[:computer_name])
  #
  #   if @computer.save
  #     @completed_computer = ComputerPart.create(computer_id: @computer.id, part_id: @part.id)
  #     render json: { computer: @completed_computer.as_json }
  #   else
  #     render json: { errors: @completed_computer.errors.full_message }
  #
  # end


  def cpu
    result = BEST_BUY.populate_list('abcat0507010')
    render json: result.as_json
  end

  def ram
    result = BEST_BUY.populate_list('abcat0506000')
    render json: result
  end

  def motherboard
    result = BEST_BUY.populate_list('abcat0507008')
    render json: result
  end

  def psu
    result = BEST_BUY.populate_list('abcat0507009')
    render json: result
  end

  def gpu
    result = BEST_BUY.populate_list('abcat0507002')
    render json: result
  end

  def hard_drive
    result = BEST_BUY.populate_list('pcmcat270900050001')
    render json: result
  end

  def solid_state
    result = BEST_BUY.populate_list('pcmcat201300050005')
    render json: result
  end

  def computer_case
    result = BEST_BUY.populate_list('abcat0507006')
    render json: result
  end
end



# http://api.remix.bestbuy.com/v1/products(sku=#{sku})?format=json&show=name,salePrice&apiKey=#{ENV['BEST_BUY_API_KEY']}
