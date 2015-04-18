class Sector
  include ActiveModel::Model
  attr_accessor :name

  class_attribute :sectors
  private_class_method :sectors
  self.sectors = {}


  def self.all
    self.sectors
  end




  def self.add_sectors(*args)
    args.each do |sector_name|
      sector_symbol = sector_name.underscore.to_sym
      sectors[sector_symbol] = Sector.new(name: sector_name)
      define_singleton_method sector_symbol do
        sectors[sector_symbol]
      end
    end
    sectors.freeze
  end

end
