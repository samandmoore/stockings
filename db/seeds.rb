
User.create!(email: 'demo@example.org', password: 'password', full_name: 'Tech Finn') unless User.find_by email: 'demo@example.org'
