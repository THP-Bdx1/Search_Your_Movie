class MoviesController < ApplicationController
  def home
  end

  def search
    @movie_infos = MovieSearcher.new(params[:name]).perform
  end

end
