class MoviesCollection
  attr_reader :movies

  def self.from_html
    kinopoisk_top_list = 'https://www.kinopoisk.ru/top/navigator/'
    parsed_page = Nokogiri::HTML(URI.open(kinopoisk_top_list))
    target_part = parsed_page.css('div.info')
    movies = []

    target_part.each do |item|
      title = item.css('div.name a').text.rstrip.gsub(/\(.*?\)/, '')
      director = item.css('i a.lined').text
      year = item.css('div.name span').text[/\(.*?\)/]

      # Включаем в массив, за исключением тех позиций у которых не указан режиссер
      # (несколько есть таких)
      movies << Movie.new(title, director, year) unless director == ''
    end

    MoviesCollection.new(movies)
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
