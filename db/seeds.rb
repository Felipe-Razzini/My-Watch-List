require 'json'
require 'uri'

response = RestClient.get 'http://tmdb.lewagon.com/movie/top_rated'
movies = JSON.parse(response)

puts 'Cleaning database...'
Movie.destroy_all

puts 'Creating movies...'
movies['results'].each do |movie|
  movie = Movie.create!(
    title: movie['original_title'],
    overview: movie['overview'],
    poster_url: "https://image.tmdb.org/t/p/w400#{movie['poster_path']}",
    rating: movie['vote_average']
  )
end
puts 'Finished!'
