class PartsController < ApplicationController
  include HTTParty
  base_uri 'http://api.remix.bestbuy.com/'

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

  # def show
  #   result = BEST_BUY.get_part(params[:sku])
  #   render json: result.as_json
  # end
  #

  def cpu
    @cpu = BestBuy.new
    @result = @cpu.get_cpus
    render json: @result
  end

  def ram
    @result = BEST_BUY.get_rams
    render json: @result
  end

  def motherboard
    @result = BEST_BUY.get_motherboards
    render json: @result
  end

  def psu
    @result = BEST_BUY.get_psus
    render json: @result
  end

  def gpu
    @result = BEST_BUY.get_gpus
    render json: @result
  end

  def hard_drive
    @result = BEST_BUY.get_hard_drives
    render json: @result
  end

  def solid_state
    @result = BEST_BUY.get_solid_states
    render json: @result
  end

  def computer_case
    @result = BEST_BUY.get_computer_cases
    render json: @result
  end
end



# http://api.remix.bestbuy.com/v1/products(sku=#{sku})?format=json&show=name,salePrice,url&apiKey=#{ENV['BEST_BUY_API_KEY']}
