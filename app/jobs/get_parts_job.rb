class GetPartsJob < ActiveJob::Base
  queue_as :default

  def perform
    @best = BestBuy.new
    cpus =         @best.get_cpus
    mobos =        @best.get_motherboards
    gpus =         @best.get_gpus
    rams =         @best.get_rams
    psus =         @best.get_psus
    hard_drives =  @best.get_hard_drives
    solid_states = @best.get_solid_states
    computer_cases = @best.get_computer_cases

    scrapin(cpus)
    scrapin(mobos)
    scrapin(gpus)
    scrapin(rams)
    scrapin(psus)
    scrapin(hard_drives)
    scrapin(solid_states)
    scrapin(computer_cases)
  end

  def scrapin(part)
    part[:parts].map {|stuff| add_or_update_part(stuff) }
  end

  def add_or_update_part(part_data)
    part = Part.find_or_create_by(name: part_data['sku'])
    part.update(make: part_data['manufacturer'],
                model: part_data['name'],
                category: part_data["categoryPath"],
                cost: part_data["salePrice"],
                store_url: part_data["url"],
                details: part_data["details"])
  end
end
