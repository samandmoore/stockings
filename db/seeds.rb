demo_user = User.create!(email: 'demo@example.org', password: 'password', full_name: 'Tech Finn') unless User.find_by email: 'demo@example.org'
second_user = User.create!(email: 'second@example.org', password: 'password', full_name: 'Gordon Schtuel') unless User.find_by email: 'second@example.org'
third_user = User.create!(email: 'third@example.org', password: 'password', full_name: 'Judge Dredd') unless User.find_by email: 'third@example.org'

%w(
  technology
  financial_services
  telecommunications
  energy
  healthcare
).each do |sector_key|
  Sector.find_or_create_by!(key: sector_key, name: sector_key.humanize, code: sector_key)
end

aapl = Ticker.create!(symbol: "AAPL", name: "Apple", cusip: "1", sector: Sector.find_by(key: "technology"))
bac = Ticker.create!(symbol: "BAC", name: "Bank of America", cusip: "2", sector: Sector.find_by(key: "financial_services"))
att = Ticker.create!(symbol: "T", name: "AT&T", cusip: "3", sector: Sector.find_by(key: "telecommunications"))
chk = Ticker.create!(symbol: "CHK", name: "Chesapeake", cusip: "4", sector: Sector.find_by(key: "energy"))
azn = Ticker.create!(symbol: "AZN", name: "Astra Zeneca", cusip: "5", sector: Sector.find_by(key: "healthcare"))

%w(A B C D E F G H I J).each do |symbol|
  offset = rand(Sector.count)
  Ticker.create!(symbol: symbol, name: symbol, cusip: symbol, sector: Sector.offset(offset).first)
end

match = Match.create!(duration: 1, max_entries: 10, wager_cents: 10_00)

[demo_user, second_user, third_user].each do |user|
  entry = match.entries.create!(
    user: user,
    technology_ticker: aapl,
    financial_services_ticker: bac,
    telecommunications_ticker: att,
    energy_ticker: chk,
    healthcare_ticker: azn,
    flex_1_ticker: Ticker.find_by!(symbol: "A"),
    flex_2_ticker: Ticker.find_by!(symbol: "B"),
    flex_3_ticker: Ticker.find_by!(symbol: "C"),
    flex_4_ticker: Ticker.find_by!(symbol: "D")
  )
  entry.save!
end


