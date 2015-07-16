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
    json.merge({ sortable_keys: ["Type of Memory (RAM)", "Storage Capacity"]})
  end

  def get_gpus
    json = self.populate_list('abcat0507002')
    json.merge({ sortable_keys: ["GPU Clock Speed", "Video Memory Capacity"]})
  end

  def get_motherboards
    json = self.populate_list('abcat0507008')
    json.merge({ sortable_keys: ["Number Of Memory Slots", "Processor Compatibility", "Maximum Memory Supported", "Processor Socket", "Form Factor"]})
  end

  def get_psus
    json = self.populate_list('abcat0507009')
    json.merge({ sortable_keys: ["Wattage"]})
  end

  def get_hard_drives
    json = self.populate_list('pcmcat270900050001')
    json.merge({ sortable_keys: ["Hard Drive Capacity", "Internal Or External", "Maximum Data Transfer Rate"]})
  end

  def get_solid_states
    json = self.populate_list('pcmcat201300050005')
    json.merge({ sortable_keys: ["Hard Drive Capacity", "Internal Or External"]})
  end

  def get_computer_cases
    json = self.populate_list('abcat0507006')
    json.merge({ sortable_keys: ["Case Type", "Power Supply"]})
  end

  def get_part(sku)
    self.class.get("http://api.remix.bestbuy.com/v1/products(sku=#{sku})?format=json&show=manufacturer,name,details.name,details.value,shortDescription,salePrice,customerReviewAverage,url,sku,categoryPath.id&apiKey=#{ENV['BEST_BUY_API_KEY']}")
  end
end
