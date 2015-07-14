class PartsController < ApplicationController

  def save_part
    @part = Part.new(name: params["sku"], make: params["manufacturer"],
                     model: params["name"], category: params["categoryPath"],
                     cost: params["salePrice"], store_url: params["url"])
    if @part.save
      render json: { part: @part.asjson }
    else
      render json: { errors: @part.errors.full_message },
      status: :not_found
    end
  end

  def cpu
    result = @best.populate_list('abcat0507010')
    render json: result.as_json
  end

  def ram
    result = @best.populate_list('abcat0506000')
    render json: result
  end

  def motherboard
    result = @best.populate_list('abcat0507008')
    render json: result
  end

  def psu
    result = @best.populate_list('abcat0507009')
    render json: result
  end

  def gpu
    result = @best.populate_list('abcat0507009')
    render json: result
  end

  def hard_drive
    result = @best.populate_list('pcmcat270900050001')
    render json: result
  end

  def solid_state
    result = @best.populate_list('pcmcat201300050005')
    render json: result
  end

  def computer_case
    result = @best.populate_list('abcat0507006')
    render json: result
  end
end



# http://api.remix.bestbuy.com/v1/products(sku=#{sku})?format=json&show=name,salePrice&apiKey=#{ENV['BEST_BUY_API_KEY']}
