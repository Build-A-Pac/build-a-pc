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
    weight = 25
    cpu_price = (weight.to_f/100) * max_price.to_i
    @cpus = Part.where(category: 'abcat0507010').select { |cpu| cpu[:cost] <= cpu_price }.sort_by {|price| price[:cost] }
    if @cpus.empty?
      weight += 3
      cpu_price = (weight.to_f/100) * max_price.to_i
      @cpus = Part.where(category: 'abcat0507010').select { |cpu| cpu[:cost] <= cpu_price }.sort_by {|price| price[:cost] }
    end
    @cpus.last
  end

  def pick_ram(max_price)
    weight = 5
    ram_price = (weight.to_f/100) * max_price.to_i
    @rams = Part.where(category: 'abcat0506000').select { |ram| ram[:cost] <= ram_price }.sort_by {|price| price[:cost] }
    if @rams.empty?
      weight += 3
      ram_price = (weight.to_f/100) * max_price.to_i
      @rams = Part.where(category: 'abcat0506000').select { |ram| ram[:cost] <= ram_price }.sort_by {|price| price[:cost] }
    end
    @rams.last
  end

  # def pick_motherboard(max_price, socket, build_type)
  #   price_limit = build_type.mobo_percent * max_price
  #   motherboards = Part.where("category = ? AND cost <= ?", foo, price_limit)
  #   valid_mobos = motherboards.select {|x| x.details["Processor Socket"].include?(socket) }
  #   if valid_mobos.empty?
  #     # If none, what do we do?
  #     puts "oh shit"
  #   else
  #     motherboards.last
  #   end
  # end

  def pick_motherboard2(max_price, socket)
    num = 14
    motherbaord_price = (num.to_f/100) * max_price.to_i
    @motherboards = Part.where(category: 'abcat0507008').select { |mobo| mobo[:cost] <= motherbaord_price }.sort_by { |price| price[:cost] }
    until !@motherboards.empty?
      num += 3
      motherbaord_price = (num.to_f/100) * max_price.to_i
      @motherboards = Part.where(category: 'abcat0507008').select { |mobo| mobo[:cost] <= motherbaord_price }.sort_by { |price| price[:cost] }
    end
      details = @motherboards.last[:details]
      details["Processor Socket"] = details.delete("CPU Socket Support") if details["CPU Socket Support"].present?

    until details['Processor Socket'] && (details['Processor Socket'].include?(socket) || socket.include?(details["Processor Socket"]))
      @motherboards.pop
      if @motherboards.empty?
        num += 3
        motherbaord_price = (num.to_f/100) * max_price.to_i
        @motherboards = Part.where(category: 'abcat0507008').select { |mobo| mobo[:cost] <= motherbaord_price }.sort_by { |price| price[:cost] }
      end
      details = @motherboards.last[:details]
      details["Processor Socket"] = details.delete("CPU Socket Support") if details["CPU Socket Support"].present?
    end
    @motherboards.last
  end


  def pick_motherboard(max_price, socket)
    num = 14
    motherbaord_price = (num.to_f/100) * max_price.to_i
    @motherboards = Part.where(category: 'abcat0507008').select { |mobo| mobo[:cost] <= motherbaord_price }.sort_by { |price| price[:cost] }
    if @motherboards.empty?
      weight += 3
      _price = (weight.to_f/100) * max_price.to_i
      @motherboards = Part.where(category: 'abcat0507008').select { |mobo| mobo[:cost] <= motherbaord_price }.sort_by { |price| price[:cost] }
    end
    details = @motherboards.last[:details]
    details["Processor Socket"] = details.delete("CPU Socket Support") if details["CPU Socket Support"].present?
    until !@motherboards.empty? && details['Processor Socket'] && (details['Processor Socket'].include?(socket) || socket.include?(details["Processor Socket"]))
      num += 3
      motherbaord_price = (num.to_f/100) * max_price.to_i
      @motherboards = Part.where(category: 'abcat0507008').select { |mobo| mobo[:cost] <= motherbaord_price }.sort_by { |price| price[:cost] }
      details = @motherboards.last[:details]
      details["Processor Socket"] = details.delete("CPU Socket Support") if details["CPU Socket Support"].present?
    end
    @motherboards.last
  end

  #give cheapest motherboard
  #find motherboards that are 14% of totalprice
  #if empty, increase % by 3
  #find detail that matches socket
  #

  def pick_storage(max_price)
    weight = 8
    storage_price = (weight.to_f/100) * max_price.to_i
    @storage = Part.where(category: 'pcmcat201300050005').select { |storage| storage[:cost] <= storage_price }.sort_by {|price| price[:cost] }
    if @storage.empty?
      weight += 3
      storage_price = (weight.to_f/100) * max_price.to_i
      @storage = Part.where(category: 'pcmcat201300050005').select { |storage| storage[:cost] <= storage_price }.sort_by {|price| price[:cost] }
    end
    @storage.last
  end

  def pick_gpu(max_price)
    weight = 34
    gpu_price = (weight.to_f/100) * max_price.to_i
    @gpus = Part.where(category: 'abcat0507002').select { |gpu| gpu[:cost] <= gpu_price }.sort_by {|price| price[:cost] }
    if @gpus.empty?
      weight += 3
      gpu_price = (weight.to_f/100) * max_price.to_i
      @gpus = Part.where(category: 'abcat0507002').select { |gpu| gpu[:cost] <= gpu_price }.sort_by {|price| price[:cost] }
    end
    @gpus.last
  end

  def pick_computer_case(max_price)
    weight = 8
    case_price = (weight.to_f/100) * max_price.to_i
    @casess = Part.where(category: 'abcat0507006').select { |cases| cases[:cost] <= case_price }.sort_by {|price| price[:cost] }
    if @casess.empty?
      weight += 3
      case_price = (weight.to_f/100) * max_price.to_i
      @casess = Part.where(category: 'abcat0507006').select { |cases| cases[:cost] <= case_price }.sort_by {|price| price[:cost] }
    end
    @casess.last
  end

  def pick_psu(max_price)
    weight = 6
    psu_price = (weight.to_f/100) * max_price.to_i
    @psus = Part.where(category: 'abcat0507009').select { |psu| psu[:cost] <= psu_price }.sort_by {|price| price[:cost] }
    if @psus.empty?
      weight += 3
      psu_price = (weight.to_f/100) * max_price.to_i
      @psus = Part.where(category: 'abcat0507009').select { |psu| psu[:cost] <= psu_price }.sort_by {|price| price[:cost] }
    end
    @psus.last
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
    json2 = json.map {|x| x.merge("categoryPath" => "abcat0506000")}
    {
      sortable_keys: ["Type of Memory (RAM)", "Storage Capacity"],
      parts: json2
    }
  end

  def get_gpus
    json = self.populate_list('abcat0507002')
    json2 = json.map {|x| x.merge("categoryPath" => "abcat0507002")}
    {
      sortable_keys: ["GPU Clock Speed", "Video Memory Capacity"],
      parts: json2
    }
  end

  def get_motherboards
    json = self.populate_list('abcat0507008')
    json2 = json.map {|x| x.merge("categoryPath" => "abcat0507008")}
    {
      sortable_keys: ["Number Of Memory Slots", "Processor Compatibility", "Maximum Memory Supported", "Processor Socket", "Form Factor"],
      parts: json2
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
