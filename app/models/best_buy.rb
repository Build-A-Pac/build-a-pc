class BestBuy
  include HTTParty
  base_uri 'http://api.remix.bestbuy.com/'

  def populate_list
    @cases = self.class.get("/v1/products(categoryPath.id=abcat0507006)?format=json&show=manufacturer,name,details.name,details.value,shortDescription,salePrice,customerReviewAverage&apiKey=ENV['BEST-BUY-API-KEY']&pageSize=50")
    binding.pry
    blah = @cases["products"][0]["details"]
    Hash[blah.map(&:values).map(&:flatten)]
    binding.pry
  end
end
