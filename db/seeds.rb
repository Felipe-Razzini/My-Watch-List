# require 'uri'
# require 'net/http'

# url = URI('https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1')
# http = Net::HTTP.new(url.host, url.port)
# http.use_ssl = true

# request = Net::HTTP::Get.new(url)
# request['accept'] = 'application/json'
# request['Authorization'] = "Bearer #{@tmdb_api_key}"

# response = http.request(request)
# @movies = JSON.parse(response.read_body)['results']
# puts @movies

# puts 'Cleaning database...'
# Movie.destroy_all

# @movies.each do |movie|
#   Movie.create!(
#     title: movie['original_title'],
#     overview: movie['overview'],
#     poster_url: "https://image.tmdb.org/t/p/w400#{movie['poster_path']}",
#     rating: movie['vote_average']
#   )
# end
# puts 'Finished!'

# def load_tmdb_api_key
#   @tmdb_api_key = ENV['MOVIE_KEY']
# end

# require 'json'
# require 'uri'

# response = RestClient.get 'http://tmdb.lewagon.com/movie/top_rated'
# movies = JSON.parse(response)

# puts 'Cleaning database...'
# Movie.destroy_all

# puts 'Creating movies...'
# movies['results'].each do |movie|
#   movie = Movie.create!(
#     title: movie['original_title'],
#     overview: movie['overview'],
#     poster_url: "https://image.tmdb.org/t/p/w400#{movie['poster_path']}",
#     rating: movie['vote_average']
#   )
# end
# puts 'Finished!'
