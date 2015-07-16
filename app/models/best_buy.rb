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
