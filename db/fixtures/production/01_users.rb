User.seed do |s|
  s.name = Faker::Name.name
  s.email = 'admin@example.com'
  s.identifier = 'admin'
  s.role_type = :admin
  s.blog_title = Faker::RockBand.name
  s.blog_description = Faker::Lorem.sentence
  s.blog_started_at = DateTime.now
  s.crypted_password = '$2a$10$jaTtxhcH1zk//NLYpHOhuOet3EZzqWdWAHtDgaXmmjAoFKJJ9BG4q'
  s.salt = 'J2svwB3sv6SzggZ7ZdHn'
end
