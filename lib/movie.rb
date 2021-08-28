class Movie
  attr_reader :title, :director, :year

  def self.from_file(file_path)
    movie_attributes = File.readlines(file_path, chomp: true)
    new(*movie_attributes)
  end

  def initialize(title, director, year)
    @title = title
    @director = director
    @year = year
  end

  # метод вернёт полную информацию по фильму
  def to_s
    "#{@director} - #{@title} (#{@year})"
  end
end
