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
end
