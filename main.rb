require 'nokogiri'
require 'open-uri'
require_relative 'lib/movie'
require_relative 'lib/movies_collection'

# Полуаем пути до всех txt файлов в папке data
all_file_paths = Dir.glob("#{__dir__}/data/*.txt")

all_movies = MoviesCollection.from_files(all_file_paths)

# Получаем всех доступных режиссёров (без повторов)
directors = all_movies.directors

puts "Программа 'Фильм на вечер':"
puts

# Выводим варианты ответов с номерами (index+1чтобы номера начинались с единицы)
directors.each_with_index do |director, index|
  puts "#{index + 1}. #{director}"
end

puts
puts "Фильм какого режиссера вы хотите сегодня посмотреть?"

# Принимаем ответ, достаем строковое представление ответа из массива directors
answer_of_user = STDIN.gets.to_i
chosen_director = directors[answer_of_user - 1]

# Предлагаем вариант из фильмов выбранного пользователем режиссера
puts "И сегодня вечером рекомендуем посмотреть:"
puts all_movies.random_movie_by_director(chosen_director)
