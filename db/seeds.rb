# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

short_url_data = [
	{ original_url: 'http://www.google.com', simplified_url: 'http://google.com' },
	{ original_url: 'http://www.facebook.com', simplified_url: 'http://facebook.com' },
	{ original_url: 'http://www.twitter.com', simplified_url: 'http://twitter.com' },
	{ original_url: 'http://www.youtube.com', simplified_url: 'http://youtube.com' },
]

short_url_data.each do |data|
  ShortenUrl.create!(data)
end