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
                    category: part["categoryPath"], cost: part["salePrice"], store_url: part["url"],
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

  def build_computer
    @best = BestBuy.new
    @cpu =           @best.pick_cpu(params[:max_price])
    @mobo =          @best.pick_motherboard(params[:max_price], @cpu['details']['Processor Socket'])
    sleep 1
    @ram =           @best.pick_ram(params[:max_price])
    @storage =       @best.pick_storage(params[:max_price])
    sleep 1
    @gpu =           @best.pick_gpu(params[:max_price])
    @computer_case = @best.pick_computer_case(params[:max_price])
    sleep 1
    @psu =           @best.pick_psu(params[:max_price])

    render json: { parts: [cpu: @cpu.as_json, motherboard: @mobo.as_json, ram: @ram.as_json, storage: @storage.as_json, gpu: @gpu.as_json, computer_case: @computer_case.as_json, psu: @psu.as_json] }
  end

end



# name: part["name"], model: part["model"]
