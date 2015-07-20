class BestBuy
  include HTTParty
  base_uri 'http://api.remix.bestbuy.com/'

  def populate_list(category)
    @cases = self.class.get("/v1/products(categoryPath.id=#{category})?format=json&show=manufacturer,name,details.name,details.value,shortDescription,salePrice,customerReviewAverage,url,sku,categoryPath.id&apiKey=#{ENV['BEST_BUY_API_KEY']}&pageSize=50")
    p = @cases["products"]
    @result = p.map do |product|
      details = product["details"].map {|x| [x['name'], x['value']]}.to_h
      product.merge({ 'details' => details })
    end
    test = @result.map do |product|
      details = product["categoryPath"].last["id"]
      product.merge({ "categoryPath" => details })
    end
  end

  def pick_cpu(max_price)
    cpu_price = (25.to_f/100) * max_price.to_i
    @cpus = self.get_cpus[:parts].select { |cpu| cpu["salePrice"] <= cpu_price }.sort_by {|price| price["salePrice"] }.last
  end

  def pick_ram(max_price)
    ram_price = (5.to_f/100) * max_price.to_i
    rams = self.get_rams[:parts].select { |ram| ram["salePrice"] <= ram_price }.sort_by {|price| price["salePrice"] }.last
  end

  def pick_motherboard(max_price)
    motherbaord_price = (14.to_f/100) * max_price.to_i
    @motherboards = self.get_motherboards[:parts].select { |mobo| mobo["salePrice"] <= motherbaord_price }.sort_by { |price| price["salePrice"] }
    until @motherboards.last["details"]["Processor Socket"].include?(@cpus["details"]["Processor Socket"])
      @motherboards.pop
    end
    @motherboards.last
  end

  def pick_storage(max_price)
    storage_price = (8.to_f/100) * max_price.to_i
    storage = self.get_solid_states[:parts].select { |storage| storage["salePrice"] <= storage_price }.sort_by {|price| price["salePrice"] }.last
  end

  def pick_gpu(max_price)
    gpu_price = (34.to_f/100) * max_price.to_i
    gpus = self.get_gpus[:parts].select { |gpu| gpu["salePrice"] <= gpu_price }.sort_by {|price| price["salePrice"] }.last
  end

  def pick_computer_case(max_price)
    case_price = (8.to_f/100) * max_price.to_i
    casess = self.get_computer_cases[:parts].select { |cases| cases["salePrice"] <= case_price }.sort_by {|price| price["salePrice"] }.last
  end

  def pick_psu(max_price)
    psu_price = (6.to_f/100) * max_price.to_i
    psus = self.get_psus[:parts].select { |psu| psu["salePrice"] <= psu_price }.sort_by {|price| price["salePrice"] }.last
  end

  def get_cpus
    json = self.populate_list('abcat0507010')
    {
      sortable_keys: ["Processor Cores", "Processor Speed", "Processor Socket"],
      parts: json
    }
  end

  def get_rams
    json = self.populate_list('abcat0506000')
    {
      sortable_keys: ["Type of Memory (RAM)", "Storage Capacity"],
      parts: json
    }
  end

  def get_gpus
    json = self.populate_list('abcat0507002')
    {
      sortable_keys: ["GPU Clock Speed", "Video Memory Capacity"],
      parts: json
    }
  end

  def get_motherboards
    json = self.populate_list('abcat0507008')
    {
      sortable_keys: ["Number Of Memory Slots", "Processor Compatibility", "Maximum Memory Supported", "Processor Socket", "Form Factor"],
      parts: json
    }
  end

  def get_psus
    json = self.populate_list('abcat0507009')
    {
      sortable_keys: ["Wattage"],
      parts: json
    }
  end

  def get_hard_drives
    json = self.populate_list('pcmcat270900050001')
    {
      sortable_keys: ["Hard Drive Capacity", "Internal Or External", "Maximum Data Transfer Rate"],
      parts: json
    }
  end

  def get_solid_states
    json = self.populate_list('pcmcat201300050005')
    {
      sortable_keys: ["Hard Drive Capacity", "Internal Or External"],
      parts: json
    }
  end

  def get_computer_cases
    json = self.populate_list('abcat0507006')
    {
      sortable_keys: ["Case Type", "Power Supply"],
      parts: json
    }
  end

  def get_part(sku)
    self.class.get("http://api.remix.bestbuy.com/v1/products(sku=#{sku})?format=json&show=manufacturer,name,details.name,details.value,shortDescription,salePrice,customerReviewAverage,url,sku,categoryPath.id&apiKey=#{ENV['BEST_BUY_API_KEY']}")
  end
end






# @motherboards.last.select {|mobo| @cpus["details"]["Processor Socket"].include?(mobo["details"]["Processor Socket"])}
