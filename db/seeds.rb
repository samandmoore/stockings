User.create!(email: 'demo@example.org', password: 'password') unless User.find_by email: 'demo@example.org'


%w(
  technology
  financial_services
  telecommunications
  energy
  healthcare
).each do |sector_key|
  Sector.find_or_create_by!(key: sector_key, name: sector_key.humanize)
end

Ticker.create!(symbol: "AAPL", sector: Sector.find_by(key: "technology"))
Ticker.create!(symbol: "BAC", sector: Sector.find_by(key: "financial_services"))
Ticker.create!(symbol: "T", sector: Sector.find_by(key: "telecommunications"))
Ticker.create!(symbol: "CHK", sector: Sector.find_by(key: "energy"))
Ticker.create!(symbol: "AZN", sector: Sector.find_by(key: "healthcare"))
