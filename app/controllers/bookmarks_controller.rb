class BookmarksController < ApplicationController
  before_action :load_tmdb_api_key
  require 'uri'
  require 'net/http'

  def new
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
    fetch_movies_from_tmdb
  end

  def create
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list), notice: 'Bookmark was successfully created.'
    else
      fetch_movies_from_tmdb
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
    url = URI('https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1')
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request['accept'] = 'application/json'
    request['Authorization'] = "Bearer #{@tmdb_api_key}"

    response = http.request(request)
    @movies = JSON.parse(response.read_body)['results']
  end
end
