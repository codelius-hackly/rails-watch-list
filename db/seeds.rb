# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts 'Destroying all bookmarks...'
Bookmark.destroy_all

puts 'Destroying all movies...'
Movie.destroy_all

puts 'Destroying all lists...'
List.destroy_all

puts 'Seeding new movies...'
# Alex Drew's way
# maybe unstringify in the JSON.parse
url = "http://tmdb.lewagon.com/movie/top_rated"
movie_serialized = URI.open(url).read
movies = JSON.parse(movie_serialized)
results = movies['results']
results.each do |movie|
  movies = Movie.create!(
    title: movie['title'],
    overview: movie['overview'],
    poster_url: "https://image.tmdb.org/t/p/w500#{movie['poster_path']}",
    rating: movie['vote_average']
  )
end

# 10.times do
#   movie = Movie.create!(
#       title: Faker::Movie.title,
#       overview: Faker::Quote.famous_last_words,
#       poster_url: Faker::LoremFlickr.image(size: "200x240", search_terms: ['movies']),
#       rating: rand(0.0..10.0).round(1)
#     )
#   puts "seeding - #{movie.title} - with rating: #{movie.rating}"
# end

puts 'Seeding some lists...'
puts 'seeding Drama list...'
List.create!(name: "Drama")
puts 'seeding Documentary list...'
List.create!(name: "Documentary")
puts 'seeding My favorites list...'
List.create!(name: "My favorites")

puts 'Seeding some bookmarks...'
10.times do
  Bookmark.create!(
    comment: Faker::Quote.yoda,
    movie: Movie.all.sample,
    list: List.all.sample
  )
end

puts 'Finished seeding!!!'
