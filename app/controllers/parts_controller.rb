class PartsController < ApplicationController

  def cpu
    @result = Part.where(category: 'abcat0507010')
    render json:
    {
      sortable_keys: ["Processor Cores", "Processor Speed", "Processor Socket"],
      parts: @result
    }
  end

  def ram
    @result = Part.where(category: 'abcat0506000')
    render json:
    {
      sortable_keys: ["Type of Memory (RAM)", "Storage Capacity"],
      parts: @result
    }
  end

  def motherboard
    @result = Part.where(category: 'abcat0507008')
    render json:
    {
      sortable_keys: ["Number Of Memory Slots", "Processor Compatibility", "Maximum Memory Supported", "Processor Socket", "Form Factor"],
      parts: @result
    }
  end

  def psu
    @result = Part.where(category: 'abcat0507009')
    render json:
    {
      sortable_keys: ["Wattage"],
      parts: @result
    }
  end

  def gpu
    @result = Part.where(category: 'abcat0507002')
    render json:
    {
      sortable_keys: ["GPU Clock Speed", "Video Memory Capacity"],
      parts: @result
    }
  end

  def hard_drive
    @result = Part.where(category: 'pcmcat270900050001')
    render json:
    {
      sortable_keys: ["Hard Drive Capacity", "Internal Or External", "Maximum Data Transfer Rate"],
      parts: @result
    }
  end

  def solid_state
    @result = Part.where(category: 'pcmcat201300050005')
    render json:
    {
      sortable_keys: ["Hard Drive Capacity", "Internal Or External"],
      parts: @result
    }
  end

  def computer_case
    @result = Part.where(category: 'abcat0507006')
    render json:
    {
      sortable_keys: ["Case Type", "Power Supply"],
      parts: @result
    }
  end
end



# http://api.remix.bestbuy.com/v1/products(sku=#{sku})?format=json&show=name,salePrice,url&apiKey=#{ENV['BEST_BUY_API_KEY']}
