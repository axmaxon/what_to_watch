class MoviesCollection
  attr_reader :movies

  def initialize(movies = [])
    @movies = movies
  end

  def directors
    @movies.map(&:director).uniq
  end

  def random_movie_by_director(chosen_director)
    @movies.select { |movie| chosen_director == movie.director }.sample
  end
end
