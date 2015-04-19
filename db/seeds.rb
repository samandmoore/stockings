demo_user = User.create!(email: 'demo@example.org', password: 'password', full_name: 'Tech Finn') unless User.find_by email: 'demo@example.org'
second_user = User.create!(email: 'second@example.org', password: 'password', full_name: 'Gordon Schtuel') unless User.find_by email: 'second@example.org'
third_user = User.create!(email: 'third@example.org', password: 'password', full_name: 'Judge Dredd') unless User.find_by email: 'third@example.org'


match = Match.create!(duration: 5, max_entries: 2, wager: 10, start_at: DateTime.new(2015, 4, 13))
entry1 = Entry.create!(user: demo_user,
                       match: match,
                       technology_ticker: Ticker.find_by!(symbol: 'CAMT'),
                       financial_services_ticker: Ticker.find_by!(symbol: 'AAL'),
                       telecommunications_ticker: Ticker.find_by!(symbol: 'ASTC'),
                       energy_ticker: Ticker.find_by!(symbol: 'ARCI'),
                       healthcare_ticker: Ticker.find_by!(symbol: 'RCPT'),
                       flex_1_ticker: Ticker.find_by!(symbol: 'MELA'),
                       flex_2_ticker: Ticker.find_by!(symbol: 'CERE'),
                       flex_3_ticker: Ticker.find_by!(symbol: 'FCSC'),
                       flex_4_ticker: Ticker.find_by!(symbol: 'FATE'))

entry2 = Entry.create!(user: third_user,
                       match: Match.last,
                       technology_ticker: Ticker.find_by!(symbol: 'AAPL'),
                       financial_services_ticker: Ticker.find_by!(symbol: 'LCNB'),
                       telecommunications_ticker: Ticker.find_by!(symbol: 'LMIA'),
                       energy_ticker: Ticker.find_by!(symbol: 'OTTR'),
                       healthcare_ticker: Ticker.find_by!(symbol: 'DXCM'),
                       flex_1_ticker: Ticker.find_by!(symbol: 'MELA'),
                       flex_2_ticker: Ticker.find_by!(symbol: 'CERE'),
                       flex_3_ticker: Ticker.find_by!(symbol: 'FCSC'),
                       flex_4_ticker: Ticker.find_by!(symbol: 'FATE'))




