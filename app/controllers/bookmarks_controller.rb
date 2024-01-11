class BookmarksController < ApplicationController
  before_action :load_tmdb_api_key

  def new
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
    fetch_movies_from_tmdb
  end

  def create
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list
    fetch_movies_from_tmdb
    if @bookmark.save
      redirect_to list_path(@list), notice: 'Bookmark was successfully created.'
      puts "Redirecting to #{list_path(@list)}"
    else
      puts "Bookmark validation failed with errors: #{params[:bookmark]}"
      puts @bookmark.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark.destroy
    redirect_to list_path(@bookmark.list), status: :see_other
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id, :list_id)
  end

  def load_tmdb_api_key
    @tmdb_api_key = ENV['MOVIE_KEY']
  end

  def fetch_movies_from_tmdb
    require 'uri'
    require 'net/http'

    url = URI('https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1')
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request['accept'] = 'application/json'
    request['Authorization'] = "Bearer #{@tmdb_api_key}"

    response = http.request(request)
    @movies = JSON.parse(response.read_body)['results']

    @movies.each do |movie|
      Movie.find_or_create_by(
        title: movie['original_title'],
        overview: movie['overview'],
        poster_url: "https://image.tmdb.org/t/p/w400#{movie['poster_path']}",
        rating: movie['vote_average']
      )
    end
  end
end
