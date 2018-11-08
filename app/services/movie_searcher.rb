require 'pry'
class MovieSearcher

    def initialize(movie_name)
        @client = Tmdb::Api.key(Rails.application.credentials.dig(:TMDB_API))
        configuration = Tmdb::Configuration.new
        configuration.base_url
        configuration.secure_base_url
        configuration.poster_sizes
        configuration.backdrop_sizes
        configuration.profile_sizes
        configuration.logo_sizes
        @movie_name = movie_name
    end
    
    def perform
        save
    end

    def save
        movie_infos=[]
        movies=Tmdb::Movie.find(@movie_name)
        movies.each do |movie|
            credit = Tmdb::Movie.credits(movie.id)
            if credit["crew"] != []
                director = credit["crew"][0]["name"]
            else director = "Unknown MADERFUKER"
            end
            if movie.poster_path == nil
               movie_infos << {"id" => movie.id, "title" => movie.original_title, "release_date" => movie.release_date, "Director" => director, "image" => "https://media.giphy.com/media/d4bn3nUNo6XpUZ4A/giphy.gif"}
            else
            movie_infos << {"id" => movie.id, "title" => movie.original_title, "release_date" => movie.release_date, "Director" => director, "image" => "http://image.tmdb.org/t/p/w500"+movie.poster_path}
            end
        end
        return movie_infos
    end
 
end