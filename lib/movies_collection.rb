class MoviesCollection
  attr_reader :movies

  def self.from_files(file_paths)
    all_movies = file_paths.map do |file_path|
      Movie.from_file(file_path)
    end

    new(all_movies)
  end

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
