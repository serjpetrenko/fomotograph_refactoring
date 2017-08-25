require 'httparty'
require 'json'

class Product

  attr_reader :id, :title, :location, :summary, :url, :price

  # ping the API for the product JSON
  LOCATIONS = ['canada', 'england', 'france', 'ireland', 'mexico', 'scotland', 'taiwan', 'us']
  url = 'https://fomotograph-api.udacity.com/products.json'
  DATA = HTTParty.get(url)['photos']

  def self.all
    DATA.map { |product| product }
  end

  def self.sample_locations
    @products = []
    LOCATIONS.each do |location|
      @products << self.all.select { |product| product['location'] == location }.sample
    end
    return @products
  end

  def self.find_by_location(location)
    self.all.select { |product| product['location'] == location }
  end

  def self.find(id)
    self.all.select { |product| product['id'] == id.to_i }.first
  end

  def self.find_by_price(limit)
    self.all.select { |product| product['price'] < limit }
  end

end
