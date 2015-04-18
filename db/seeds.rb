User.create!(email: 'demo@example.org', password: 'password') unless User.find_by email: 'demo@example.org'


%w(
  technology
  financial_services
  telecommunications
  energy
  healthcare
).each do |sector_key|
  Sector.find_or_create_by!(key: sector_key, name: sector_key.humanize, code: sector_key)
end

Ticker.create!(symbol: "AAPL", name: "Apple", cusip: "1", sector: Sector.find_by(key: "technology"))
Ticker.create!(symbol: "BAC", name: "Bank of America", cusip: "2", sector: Sector.find_by(key: "financial_services"))
Ticker.create!(symbol: "T", name: "AT&T", cusip: "3", sector: Sector.find_by(key: "telecommunications"))
Ticker.create!(symbol: "CHK", name: "Chesapeake", cusip: "4", sector: Sector.find_by(key: "energy"))
Ticker.create!(symbol: "AZN", name: "Astra Zeneca", cusip: "5", sector: Sector.find_by(key: "healthcare"))
