class Movie
  attr_reader :title, :director, :year

  def initialize(title, director, year)
    @title = title
    @director = director
    @year = year
  end

  # метод вернёт полную информацию по фильму
  def to_s
    "#{@director} - #{@title} #{@year}"
  end
end
