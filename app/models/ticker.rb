class Ticker < ActiveRecord::Base
  belongs_to :sector
  belongs_to :industry, class_name: 'Sector'

  Sector::KEYS.each do |scope_name|
    scope scope_name, -> { joins(:sector).merge(Sector.public_send(scope_name)) }
  end

  validates :name, :cusip, :symbol, presence: true
  validates :symbol, :cusip, uniqueness: true
end
