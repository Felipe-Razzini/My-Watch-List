require 'uri'
require 'net/http'

url = URI("https://api.themoviedb.org/3/movie/popular?language=en-US&page=1")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true

request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'

response = http.request(request)
puts response.read_body
