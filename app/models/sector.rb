class Sector < ActiveRecord::Base
  KEYS = %i(
    technology
    financial_services
    telecommunications
    energy
    healthcare
  ).freeze

  KEYS.each do |scope_name|
    scope scope_name, -> { where(key: scope_name.to_s) }
  end

  validates :name, :key, :code, presence: true
end
