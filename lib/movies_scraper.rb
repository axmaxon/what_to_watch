module MoviesScraper
  extend self

  KINOPOISK_TOP_LIST = 'https://www.kinopoisk.ru/top/navigator/'

  def parse_kinopoisk_top_list
    parsed_page = parse_page(KINOPOISK_TOP_LIST)
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

  private

  def parse_page(page_url)
    Nokogiri::HTML(URI.open(page_url, &:read))
  end
end
