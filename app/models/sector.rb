class Sector < ActiveRecord::Base
  KEYS = %i(
    technology
    financial_services
    telecommunications
    energy
    healthcare
  ).freeze

  scope :technology, -> { where(key: 'technology') }
  scope :financial_services, -> { where(key: 'financial') }
  scope :telecommunications, -> { where(key: 'conglomerates') }
  scope :energy, -> { where(key: 'utilities') }
  scope :healthcare, -> { where(key: 'healthcare') }

  validates :name, :key, :code, presence: true
end
