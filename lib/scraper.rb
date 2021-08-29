class Scraper
  KINOPOISK_TOP_LIST = 'https://www.kinopoisk.ru/top/navigator/'

  def self.parse_html
    parsed_page = Nokogiri::HTML(URI.open(KINOPOISK_TOP_LIST))
    target_part = parsed_page.css('div.info')

    target_part.filter_map do |item|
      title = item.css('div.name a').text.rstrip.gsub(/\(.*?\)/, '')
      director = item.css('i a.lined').text
      year = item.css('div.name span').text[/\(.*?\)/]

      # Включаем в массив, за исключением тех позиций у которых не указан режиссер
      # (несколько есть таких)
      Movie.new(title, director, year) unless director.empty?
    end
  end
end
