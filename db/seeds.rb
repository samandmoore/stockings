User.create!(email: 'demo@example.org', password: 'password') unless User.find_by email: 'demo@example.org'
